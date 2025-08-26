/*import 'dart:io';
import 'package:calculator_app/Services/audio_extracter.dart';
import 'package:calculator_app/Services/pdf_generator.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/whisper_service.dart';


class VideoToPDFPage extends StatefulWidget {
  const VideoToPDFPage({super.key});
  @override
  State<VideoToPDFPage> createState() => _VideoToPDFPageState();
}

class _VideoToPDFPageState extends State<VideoToPDFPage> {
  
  bool isLoading = false;String? transcript;

  Future<void> processVideo() async {
    setState(() => isLoading = true);

    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return;

    final videoFile = File(result.files.single.path!);
    final audioFile = await extractAudioFromVideo(videoFile);
    if (audioFile == null) {
      setState(() => isLoading = false);
      print("❌ Audio extraction failed.");
      return;
    }

    final text = await transcribeAudioWithOpenAI(audioFile);
    if (text == null) {
      setState(() => isLoading = false);
      print("❌ Transcription failed.");
      return;
    }

    setState(() {
      transcript = text;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video to PDF Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: processVideo,
              icon: const Icon(Icons.video_library),
              label: const Text("Pick Video & Generate Summary"),
            ),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (transcript != null) ...[
              Expanded(child: SingleChildScrollView(child: Text(transcript!))),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => generateAndOpenPDF(context, transcript!),
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("Download as PDF"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}*/
