import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String?> transcribeAudioWithOpenAI(File audioFile,
    {bool translateToEnglish = false}) async {
  final apiKey = dotenv.env['OPENAI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    print("❌ No API key found. Did you set it in .env?");
    return null;
  }

  // Choose endpoint based on mode
  final url = Uri.parse(
    translateToEnglish
        ? "https://api.openai.com/v1/audio/translations"
        : "https://api.openai.com/v1/audio/transcriptions",
  );

  try {
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..files.add(await http.MultipartFile.fromPath('file', audioFile.path))
      ..fields['model'] = 'whisper-1';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("✅ Whisper success: text length = ${data['text']?.length}");
      return data['text'];
    } else {
      // Print full error details
      print("❌ Whisper error [${response.statusCode}]: ${response.body}");

      // Specific handling for rate limit
      if (response.statusCode == 429) {
        print("⚠️ You are being rate-limited. Try again after a short delay.");
      }
      return null;
    }
  } catch (e) {
    print("💥 Exception during transcription: $e");
    return null;
  }
}
