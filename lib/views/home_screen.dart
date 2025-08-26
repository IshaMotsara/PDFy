import 'dart:developer';
import 'dart:io';
import 'package:PDFY/services/pdf_generator.dart';
import 'package:PDFY/utils/widgets/common_widget.dart';
import 'package:PDFY/utils/widgets/gradient_background_screen.dart';
import 'package:PDFY/utils/widgets/text_style_screen.dart';
import 'package:PDFY/viewmodels/media_processing_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  String? transcript;

  @override
Widget build(BuildContext context) {
  return GradientBackground(
    child: Scaffold(
      backgroundColor: Colors.transparent, // important for gradient
      body: Consumer<CountProvider>(
        builder: (context, provider, child) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Picture
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 4,
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

                    const SizedBox(height: 20),

                    // TextField
                    Custom.customTextField(
                       provider.imagecontroller,
                       "Select Pictures",
                       Icons.image,          // pass an IconData
                        false,                // not a password field, so false
                       TextInputType.text,
                       ),

                    const SizedBox(height: 20),

                    // Button
                    Custom.customButton(
                 onPressed: () async {
                 File? video = await provider.pickMediaFile();
                  if (video != null) {
                    await provider.processAndUploadFile();
                    final pdfPath = await generateAndOpenPDF(
                      context,
                    'Generated Pdf',
                    provider.transcript ?? 'No transcription available',
                    ); 
                if (pdfPath != null && pdfPath.isNotEmpty) {
                await OpenFile.open(pdfPath);
                }
                  }
                    },
                       text:  "Pick Video for Transcription",
                        ),


                    const SizedBox(height: 20),

                    // Video Thumbnail
                    provider.videoThumbnail != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              provider.videoThumbnail!,
                              width: 200,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Text("No video thumbnail",
                        style:AppTextStyles.body ,
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

}
