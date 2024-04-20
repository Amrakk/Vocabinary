import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vocabinary/widgets/my_icon_button.dart';
import 'package:vocabinary/data/caches/audio_cache_manager.dart';
import 'package:vocabinary/widgets/audio_button/audio_button_controller.dart';

class AudioButton extends StatefulWidget {
  final String word;
  final String? url;
  final double size;
  final AudioButtonController? controller;

  const AudioButton({
    required this.word,
    this.url,
    this.size = 40,
    this.controller,
    super.key,
  });

  @override
  State<AudioButton> createState() => AudioButtonState();
}

class AudioButtonState extends State<AudioButton> {
  late AudioPlayer _player;
  bool _isProcessing = false;

  void _init() async {
    String url;
    if (widget.url == null || widget.url!.isEmpty) {
      url = dotenv.get('AUDIO_ALT_API') + widget.word;
    } else {
      url = widget.url!;
    }

    _player = AudioPlayer();
    if (kIsWeb) {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url))).then(
        (value) async {
          _player.playerStateStream.listen((event) async {
            if (event.processingState == ProcessingState.completed) {
              setState(() {
                _isProcessing = false;
              });
              await _player.stop();
            }
          });
        },
      ).catchError((_) {
        // TODO: handle 404 from google tts (web platform)
      });
      return;
    }

    await AudioCacheManager.getAudioSource(url).then(
      (value) async {
        await _player.setAudioSource(value);
        _player.playerStateStream.listen((event) async {
          if (event.processingState == ProcessingState.completed) {
            setState(() {
              _isProcessing = false;
            });
          }
        });
      },
    ).catchError((_) {});
  }

  @override
  void initState() {
    _init();
    super.initState();
    widget.controller?.state = this;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    if (_isProcessing) return;
    await _player.seek(Duration.zero);
    setState(() {
      _isProcessing = true;
    });

    await _player.play();
  }

  @override
  Widget build(BuildContext context) {
    return _isProcessing
        ? MyIconButton(
            icon: Icons.volume_up_rounded,
            size: Dimensions.iconSize(context, widget.size),
          )
        : MyIconButton(
            onTap: playAudio,
            icon: Icons.volume_mute_rounded,
            size: Dimensions.iconSize(context, widget.size),
          );
  }
}
