import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<String> getAudioDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${dir.path}/audios');
    if (!audioDir.existsSync()) {
      audioDir.createSync(recursive: true);
    }
    return audioDir.path;
  }

  static Future<String> getVideoDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final videoDir = Directory('${dir.path}/videos');
    if (!videoDir.existsSync()) {
      videoDir.createSync(recursive: true);
    }
    return videoDir.path;
  }
}