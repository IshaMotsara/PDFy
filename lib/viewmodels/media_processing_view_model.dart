import 'dart:developer';
import 'dart:io';
import 'package:PDFY/models/whisper_api.dart';
import 'package:PDFY/services/audio_extractor.dart';
import 'package:PDFY/services/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  
  
  String? videoPath;
  String? pdfPath;

  void reset() {
   _pickedFile = null;        // ✅ clear previously picked file
  _videoThumbnail = null;    // ✅ clear old thumbnail
  videoPath = null;
  pdfPath = null;
  _isLoading = false;
  _transcript = null;
  _uploadedFileUrl = null;
  imagecontroller.clear();   // ✅ clear input field too if needed
  notifyListeners();
  }

  void setVideoPath(String path) {
    videoPath = path;
    notifyListeners();
  }

  void setTranscript(String text) {
    _transcript = text;
    notifyListeners();
  }

  void setPdfPath(String path) {
    pdfPath = path;
    notifyListeners();
  }



  /// Step 1 - Pick a file (video or image) and create thumbnail if video
  Future<File?> pickMediaFile() async {
    bool granted = await requestVideoPermission();
    if (!granted) {
      print("❌ Permission not granted");
      return null;
    }

    try {
       reset();
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        
      );

      if (result != null && result.files.single.path != null) {
        final path = result.files.single.path!;
        final file = File(path);
        _pickedFile = file;
        setVideoPath(path);

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

    
    if (_pickedFile == null) {
      print("❌ No file selected");
      _isLoading = false;
      notifyListeners();
      return;
    }
    final file = _pickedFile!;
    String? fileType = _isVideo(file.path) ? "video" : "image";

    // If it's a video, extract audio & transcribe
    if (fileType == "video") {
      final audioFile = await extractAudioFromVideo(file);
      if (audioFile != null) {
        final text = await transcribeAudioWithOpenAI(audioFile);
        setTranscript(text ?? "");
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
