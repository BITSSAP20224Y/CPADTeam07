import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/attempt.dart';
import 'video_recorder_screen.dart';
import 'voice_recorder_screen.dart';

class QuestScreen extends StatefulWidget {
  @override
  _QuestScreenState createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  final List<Map<String, String>> objects = [
    {'emoji': '🐱', 'name': 'cat'},
    {'emoji': '🍎', 'name': 'apple'},
    {'emoji': '☕', 'name': 'cup'},
    {'emoji': '🚗', 'name': 'car'},
    {'emoji': '💻', 'name': 'laptop'},
    {'emoji': '🪑', 'name': 'chair'},
  ];

  late Map<String, String> currentQuest;

  @override
  void initState() {
    super.initState();
    currentQuest = getRandomQuest();
  }

  Map<String, String> getRandomQuest() {
    final random = Random();
    return objects[random.nextInt(objects.length)];
  }

  void saveAttempt(bool success, String mediaPath, String mediaType) async {
    final box = Hive.box('quest_results');
    final attempt = Attempt(
      questEmoji: currentQuest['emoji']!,
      questName: currentQuest['name']!,
      mediaPath: mediaPath,
      mediaType: mediaType,
      success: success,
      timestamp: DateTime.now(),
    );
    await box.add(attempt);

    // Show result dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(success ? "You Win! 🎉" : "Try Again! ❌"),
        content: Text(success
            ? "Object ${currentQuest['emoji']} detected successfully."
            : "Object ${currentQuest['emoji']} not detected."),
        actions: [
          TextButton(
            child: Text("Next Quest"),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuest = getRandomQuest();
              });
            },
          ),
          TextButton(
            child: Text("Back to Home"),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  Future<void> onVideoRecorded(String videoPath) async {
    // TODO: Run YOLO detection on videoPath
    // For now, randomly simulate success

    bool detected = Random().nextBool(); // replace with real YOLO result

    saveAttempt(detected, videoPath, 'video');
  }

  Future<void> onVoiceRecorded(String audioPath) async {
    // TODO: Run voice keyword matching on audioPath
    // For now, randomly simulate success

    bool detected = Random().nextBool(); // replace with real keyword spotting

    saveAttempt(detected, audioPath, 'audio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Find this object:',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 12),
            Text(
              currentQuest['emoji']!,
              style: TextStyle(fontSize: 80),
            ),
            SizedBox(height: 12),
            Text(
              currentQuest['name']!,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              icon: Icon(Icons.videocam),
              label: Text('Record Video'),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              onPressed: () async {
                final videoPath = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoRecorderScreen(),
                  ),
                );
                if (videoPath != null) {
                  await onVideoRecorded(videoPath);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.mic),
              label: Text('Record Voice'),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              onPressed: () async {
                final audioPath = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VoiceRecorderScreen(),
                  ),
                );
                if (audioPath != null) {
                  await onVoiceRecorded(audioPath);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
