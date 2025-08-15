import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:sagar_new_project/Provider/count_provider.dart';
import 'package:sagar_new_project/Services/audio_extractor.dart';
import 'package:sagar_new_project/Services/pdf_generator.dart';
import 'package:sagar_new_project/Services/whisper_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  String? transcript;

  // Future<void> processVideo() async {
  //   setState(() => isLoading = true);

  //   final result = await FilePicker.platform.pickFiles(type: FileType.video);
  //   if (result == null) return;

  //   final videoFile = File(result.files.single.path!);
  //   final audioFile = await extractAudioFromVideo(videoFile);
  //   if (audioFile == null) {
  //     setState(() => isLoading = false);
  //     print("❌ Audio extraction failed.");
  //     return;
  //   }

  //   final text = await transcribeAudioWithOpenAI(audioFile);
  //   if (text == null) {
  //     setState(() => isLoading = false);
  //     print("❌ Transcription failed.");
  //     return;
  //   }

  //   setState(() {
  //     transcript = text;
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("Sagar 1");
    return Scaffold(body: Container(
        child: Consumer<CountProvider>(builder: (context, provider, child) {
      print("Sagar 2");
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                 
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: provider.imagecontroller,
                decoration: const InputDecoration(
                    labelText: 'Select Pictures',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              )),
          


ElevatedButton(
  onPressed: () async {
    File? video = await provider.pickMediaFile();

    if (video != null) {
      print("🎥 Picked video file path: ${video.path}");
      await provider.processAndUploadFile();

      // Step 1: Generate PDF (this should return the PDF file path)
      final pdfPath = await generateAndOpenPDF(
        context,
        'Generated Pdf',
        provider.transcript ?? 'No transcription available',
      );

      // Step 2: Open PDF if it exists
      if (pdfPath != null && pdfPath.isNotEmpty) {
        final result = await OpenFile.open(pdfPath);
        print("📂 OpenFile result: ${result.toString()} - ${result.message}");
      } else {
        print("❌ PDF path is null or empty");
      }
    }
  },
  child: const Text("Pick Video for Transcription"),
),


const SizedBox(height: 10),

// Thumbnail Preview
provider.videoThumbnail != null
    ? Image.memory(
        provider.videoThumbnail!,
        width: 200,
        height: 120,
        fit: BoxFit.cover,
      )
    : Text("No video thumbnail"),




          
        ],
      );
    })));
  }
}
