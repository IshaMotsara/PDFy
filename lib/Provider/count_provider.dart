import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sagar_new_project/Services/audio_extractor.dart';
import 'package:sagar_new_project/Services/permission_handler.dart';
import 'package:sagar_new_project/Services/whisper_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CountProvider with ChangeNotifier {
  File? _pickedFile;                 // Original picked file (image/video)
  Uint8List? _videoThumbnail;        // Thumbnail bytes (if video)
  bool _isLoading = false;           // Loading indicator
  String? _transcript;               // Transcript from OpenAI
  String? _uploadedFileUrl;          // Firebase Storage file URL
  TextEditingController imagecontroller = TextEditingController();

  File? get pickedFile => _pickedFile;
  Uint8List? get videoThumbnail => _videoThumbnail;
  bool get isLoading => _isLoading;
  String? get transcript => _transcript;
  String? get uploadedFileUrl => _uploadedFileUrl;

  /// Step 1 - Pick a file (video or image) and create thumbnail if video
  Future<File?> pickMediaFile() async {
    bool granted = await requestVideoPermission();
    if (!granted) {
      print("❌ Permission not granted");
      return null;
    }

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        
      );

      if (result != null && result.files.single.path != null) {
        final path = result.files.single.path!;
        final file = File(path);
        _pickedFile = file;

        // ✅ If it's a video, generate thumbnail
        if (_isVideo(path)) {
          _videoThumbnail = await VideoThumbnail.thumbnailData(
            video: file.path,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 200,
            quality: 75,
          );
        } else {
          _videoThumbnail = null;
        }

        notifyListeners();
        print("✅ File ready.");
        return file;
      } else {
        print("❌ No file selected");
        return null;
      }
    } catch (e) {
      print("❌ File picking error: $e");
      return null;
    }
  }

  /// Step 2 - Process the file (extract audio & transcribe if video) + upload
  Future<void> processAndUploadFile() async {
    _isLoading = true;
    notifyListeners();

    print("🌀 Starting processAndUploadFile");

    final file = await pickMediaFile();
    if (file == null) {
      print("❌ No file selected");
      _isLoading = false;
      notifyListeners();
      return;
    }

    String? fileType = _isVideo(file.path) ? "video" : "image";

    // If it's a video, extract audio & transcribe
    if (fileType == "video") {
      final audioFile = await extractAudioFromVideo(file);
      if (audioFile != null) {
        final text = await transcribeAudioWithOpenAI(audioFile);
        _transcript = text;
      }
    }

    // ✅ Upload file to Firebase Storage
    

    _isLoading = false;
    notifyListeners();
  }

  /// Upload file to Firebase Storage
  uploadData() async {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("Profile Pics")
            .child(imagecontroller.text.toString())
            .putFile(_pickedFile!);
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


  /// Helper - Check if file is a video
  bool _isVideo(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'avi'].contains(ext);
  }
}
