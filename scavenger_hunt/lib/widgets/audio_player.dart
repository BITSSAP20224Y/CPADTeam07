import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String filePath;
  const AudioPlayerWidget({Key? key, required this.filePath}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openPlayer();
  }

  void _togglePlayback() async {
    if (_isPlaying) {
      await _player.stopPlayer();
    } else {
      await _player.startPlayer(fromURI: widget.filePath);
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      label: Text(_isPlaying ? 'Pause' : 'Play'),
      onPressed: _togglePlayback,
    );
  }
}