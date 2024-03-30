import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vocabinary/utils/dimensions.dart';

class AudioButton extends StatelessWidget {
  final player = AudioPlayer();

  final String url;
  final double size;

  AudioButton({required this.url, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    bool isProcessing = false;
    return Ink(
      padding: EdgeInsets.all(Dimensions.padding10(context)),
      decoration: const ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: () async {
          if (isProcessing) return;
          Future.delayed(const Duration(milliseconds: 400), () {
            isProcessing = false;
          });

          await player.play(UrlSource(url)).catchError((e) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
              ),
            );
          });
          isProcessing = true;
        },
        color: Colors.white,
        icon: Icon(CupertinoIcons.speaker_2_fill, size: size),
      ),
    );
  }
}
