import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final CameraDescription camera;
  final Function(XFile) onVideoRecorded;

  const CameraView({Key? key, required this.camera, required this.onVideoRecorded}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final file = await _controller.stopVideoRecording();
      widget.onVideoRecorded(file);
    } else {
      await _controller.startVideoRecording();
    }
    setState(() => _isRecording = !_isRecording);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        AspectRatio(aspectRatio: _controller.value.aspectRatio, child: CameraPreview(_controller)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _toggleRecording,
          icon: Icon(_isRecording ? Icons.stop : Icons.videocam),
          label: Text(_isRecording ? 'Stop' : 'Record'),
        )
      ],
    );
  }
}