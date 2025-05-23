import 'package:hive/hive.dart';

part 'attempt.g.dart';

@HiveType(typeId: 0)
class Attempt extends HiveObject {
  @HiveField(0)
  String questEmoji;

  @HiveField(1)
  String questName;

  @HiveField(2)
  String mediaPath;  // video or audio path

  @HiveField(3)
  String mediaType;  // 'video' or 'audio'

  @HiveField(4)
  bool success;

  @HiveField(5)
  DateTime timestamp;

  Attempt({
    required this.questEmoji,
    required this.questName,
    required this.mediaPath,
    required this.mediaType,
    required this.success,
    required this.timestamp,
  });
}
