import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vocabinary/data/caches/audio_cache_manager.dart';

import 'package:vocabinary/utils/dimensions.dart';

class AudioButton extends StatefulWidget {
  final String url;

  const AudioButton({required this.url, super.key});

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  late AudioPlayer _player;
  bool isProcessing = false;

  void _init() async {
    _player = AudioPlayer();
    final audioSource = await AudioCacheManager.getAudioSource(widget.url);

    await _player.setAudioSource(audioSource);
    _player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        setState(() {
          isProcessing = false;
        });
      }
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _dispose() async {
    await AudioCacheManager.removeAudioSource(widget.url);
    await AudioCacheManager.dispose();
    await _player.dispose();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isProcessing
          ? null
          : () async {
              await _player.seek(Duration.zero);
              setState(() {
                isProcessing = true;
              });
              AudioCacheManager.stat();
              await _player.play().catchError((e) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              });
            },
      child: Container(
        height: Dimensions.height(context, 40),
        width: Dimensions.width(context, 40),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isProcessing
            ? const Icon(Icons.volume_up)
            : const Icon(Icons.volume_mute),
      ),
    );
  }
}
