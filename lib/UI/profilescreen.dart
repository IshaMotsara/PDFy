import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sagar_new_project/Provider/count_provider.dart';
import 'package:sagar_new_project/Services/audio_extractor.dart';
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
                  child: ClipOval(
                    child: provider.imageFile != null
                        ? Image.file(
                            provider.imageFile!,
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                            height: 170,
                            fit: BoxFit.cover,
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
                    labelText: 'Select Image',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              )),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              // side: BorderSide(color: Colors.yellow, width: 5),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontStyle: FontStyle.normal,
              ),
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            icon: const Icon(Icons.image_outlined),
            onPressed: () {
              provider.processVideo();
              provider.pickImage(ImageSource.gallery);
              provider.uploadimage(context);
            },
            label: const Text("Pick Gallery"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              // side: BorderSide(color: Colors.yellow, width: 5),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontStyle: FontStyle.normal,
              ),
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {
              provider.processVideo();
              provider.pickImage(ImageSource.camera);
              provider.uploadimage(context);
            },
            label: const Text("Pick Camera"),
          ),

          TextButton(onPressed: (){
            provider.changeBool();
          }, child: Text(provider.sagar? "Hit Sagar" : "Dont hit Sagar"))
        ],
      );
    })));
  }
}
