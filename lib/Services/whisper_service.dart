import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String?> transcribeAudioWithOpenAI(File audioFile) async {
  final apiKey =  dotenv.env['OPENAI_API_KEY']; // replace with your actual key
  final url = Uri.parse("https://api.openai.com/v1/audio/transcriptions");

  var request = http.MultipartRequest('POST', url)
    ..headers['Authorization'] = 'Bearer $apiKey'
    ..files.add(await http.MultipartFile.fromPath('file', audioFile.path))
    ..fields['model'] = 'whisper-1';

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  print("✅ Step 2 done: Whisper returned text length = }");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("❌ Whisper error: ${response.body}");
    return data['text'];
    
  }
  
   else {
    
    return null;
  }
  
  
}
