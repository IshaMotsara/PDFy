import 'dart:io';

import 'package:ffmpeg_kit_flutter_new_gpl/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> extractAudioFromVideo(File videoFile) async {
  final appDir = await getTemporaryDirectory();
  final audioPath = "${appDir.path}/output_audio.mp3";
  final command = "-i ${videoFile.path} -vn -acodec libmp3lame -q:a 2 $audioPath";

  await FFmpegKit.execute(command);

  final audioFile = File(audioPath);
  return await audioFile.exists() ? audioFile : null;
}
