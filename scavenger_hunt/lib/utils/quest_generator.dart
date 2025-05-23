import '../constants/quest_list.dart';
import 'dart:math';

String getRandomQuest() {
  final random = Random();
  return questObjects[random.nextInt(questObjects.length)];
}