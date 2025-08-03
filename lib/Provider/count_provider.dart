import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sagar_new_project/Services/audio_extractor.dart';
import 'package:sagar_new_project/Services/whisper_service.dart';

class CountProvider with ChangeNotifier {
  File? _imageFile;
   

  File? get imageFile => _imageFile;

  bool sagar = false;

  changeBool(){
    sagar = !sagar;
    notifyListeners();
  }
  TextEditingController imagecontroller = TextEditingController();
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      _imageFile = tempImage;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  uploadimage(BuildContext context) {
    if (imageFile == null) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Enter Required Fields"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("okk"))
              ],
            );
          });
    } else {
      uploadData() async {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("Profile Pics")
            .child(imagecontroller.text.toString())
            .putFile(imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection("Users")
            .doc(imagecontroller.text.toString())
            .set({"Email": imagecontroller.text.toString(), "Image": url}).then(
                (Value) {
          log("user uploaded");
        });
      }
    }
  }
  bool _isLoading = false;
  String? _transcript;
 bool? get isLoading => _isLoading;
  String? get transcript => _transcript;
 

  Future<void> processVideo() async {
    _isLoading = true;

    final result = await FilePicker.platform.pickFiles(type: FileType.video);
   if (result == null) return;

     final videoFile = File(result.files.single.path!);
     final audioFile = await extractAudioFromVideo(videoFile);
     if (audioFile == null) {
         _isLoading = false;
       print("❌ Audio extraction failed.");
      return;
     }

    final text = await transcribeAudioWithOpenAI(audioFile);
    if (text == null) {
        _isLoading = false;
     print("❌ Transcription failed.");
      return;
     }

    
      _transcript = text;
       _isLoading = false;
    notifyListeners();
   }
}
