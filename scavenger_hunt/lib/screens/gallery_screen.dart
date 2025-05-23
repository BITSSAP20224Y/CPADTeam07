import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../models/attempt.dart';

class GalleryScreen extends StatelessWidget {
  final Box box = Hive.box('quest_results');

  @override
  Widget build(BuildContext context) {
    List<Attempt> attempts =
        box.values.whereType<Attempt>().toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: attempts.isEmpty
          ? Center(child: Text("No attempts yet. Play to create some!"))
          : ListView.builder(
              itemCount: attempts.length,
              itemBuilder: (context, index) {
                final att = attempts[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Text(
                      att.questEmoji,
                      style: TextStyle(fontSize: 30),
                    ),
                    title: Text(att.questName),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(att.timestamp),
                    ),
                    trailing: Icon(
                      att.success ? Icons.check_circle : Icons.cancel,
                      color: att.success ? Colors.green : Colors.red,
                    ),
                    onTap: () {
                      // Open media file preview: For simplicity,
                      // we just show a dialog with path.
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('${att.mediaType.toUpperCase()} Preview'),
                          content: Text('File path:\n${att.mediaPath}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
