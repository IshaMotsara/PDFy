import 'dart:io';
import 'package:ffmpeg_kit_flutter_new_gpl/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> extractAudioFromVideo(File videoFile) async {
  print("🎬 Starting audio extraction from video: ${videoFile.path}");

  // ✅ Check if the file actually exists
  if (!await videoFile.exists()) {
    print("❌ Video file does not exist at: ${videoFile.path}");
    return null;
  }

  final appDir = await getTemporaryDirectory();
  final audioPath = "${appDir.path}/output_audio.mp3";

  // ✅ Use quotes to protect paths with spaces
  final command = '-i "${videoFile.path}" -vn -acodec libmp3lame -q:a 2 "$audioPath"';

  print("📂 Temporary directory: ${appDir.path}");
  print("🛠️ FFmpeg command: $command");

  final session = await FFmpegKit.execute(command);
  final returnCode = await session.getReturnCode();

  if (returnCode != null && returnCode.isValueSuccess()) {
    print("✅ Audio extraction successful.");
    final audioFile = File(audioPath);
    if (await audioFile.exists()) {
      print("📁 Extracted audio file path: $audioPath");
      return audioFile;
    } else {
      print("❌ Audio file not found even though FFmpeg reported success.");
      return null;
    }
  } else {
    print("❌ FFmpeg command failed.");
    // ✅ Print all logs for debugging
    final logs = await session.getAllLogs();
    for (var log in logs) {
      print("📝 FFmpeg log: ${log.getMessage()}");
    }
    return null;
  }
}
