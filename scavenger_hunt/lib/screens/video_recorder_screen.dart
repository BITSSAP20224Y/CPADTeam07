import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class VideoRecorderScreen extends StatefulWidget {
  @override
  _VideoRecorderScreenState createState() => _VideoRecorderScreenState();
}

class _VideoRecorderScreenState extends State<VideoRecorderScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    if (cameras!.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No camera found")));
      return;
    }
    controller = CameraController(cameras!.first, ResolutionPreset.medium);
    await controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<String> getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    final uuid = Uuid().v4();
    return '${dir.path}/$uuid.mp4';
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void startRecording() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (isRecording) return;

    await controller!.startVideoRecording();
    setState(() {
      isRecording = true;
    });

    // Automatically stop after 10 seconds
    Future.delayed(Duration(seconds: 10), () async {
      if (isRecording) await stopRecording();
    });
  }

  Future<void> stopRecording() async {
    if (controller == null || !controller!.value.isRecordingVideo) return;

    XFile videoFile = await controller!.stopVideoRecording();

    setState(() {
      isRecording = false;
    });

    // Save to app directory
    final savePath = await getFilePath();
    await videoFile.saveTo(savePath);

    Navigator.pop(context, savePath);
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('Record Video')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Record Video (max 10s)')),
      body: Stack(
        children: [
          CameraPreview(controller!),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: isRecording ? Colors.red : Colors.green,
                child: Icon(isRecording ? Icons.stop : Icons.videocam),
                onPressed: () {
                  if (isRecording) {
                    stopRecording();
                  } else {
                    startRecording();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
