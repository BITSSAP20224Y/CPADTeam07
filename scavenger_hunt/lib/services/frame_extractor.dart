import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

class FrameExtractor {
  Future<List<Uint8List>> extractFramesFromVideo(String videoPath, {int frameCount = 3}) async {
    final dir = await getTemporaryDirectory();
    List<Uint8List> frames = [];

    for (int i = 0; i < frameCount; i++) {
      final timestamp = i * 1;
      final outputPath = '${dir.path}/frame_$i.jpg';
      await FFmpegKit.execute(
          '-i "$videoPath" -ss 00:00:0$timestamp -vframes 1 "$outputPath"');

      final file = File(outputPath);
      if (file.existsSync()) {
        frames.add(await file.readAsBytes());
      }
    }
    return frames;
  }
}