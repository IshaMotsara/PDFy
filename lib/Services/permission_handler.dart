import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

Future<bool> requestVideoPermission() async {
  if (Platform.isAndroid) {
    // For Android 13+ use READ_MEDIA_VIDEO
    var status = await Permission.videos.status;
    if (!status.isGranted) {
      status = await Permission.videos.request();
    }
    return status.isGranted;
  }
  return true; // iOS or other platforms
}
