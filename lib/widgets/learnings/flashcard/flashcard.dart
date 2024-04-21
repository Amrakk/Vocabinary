import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:vocabinary/widgets/audio_button/audio_button.dart';
import 'package:vocabinary/widgets/audio_button/audio_button_controller.dart';
import 'package:vocabinary/widgets/learnings/flashcard/flashcard_controller.dart';

class Flashcard extends StatefulWidget {
  final WordModel word;
  final FlashcardController? controller;

  const Flashcard({required this.word, this.controller, super.key});

  @override
  State<Flashcard> createState() => FlashcardState();
}

class FlashcardState extends State<Flashcard> {
  late FlipCardController _flipCardController;
  late AudioButtonController _audioButtonController;

  bool _isFront = true;
  bool _isPlaying = false;
  Color _borderColor = Colors.transparent;

  @override
  void initState() {
    _flipCardController = FlipCardController();
    _audioButtonController = AudioButtonController();
    super.initState();

    widget.controller?.state = this;
  }

  Future<void> flipCard() {
    return _flipCardController.toggleCard();
  }

  bool get isFront => _flipCardController.state!.isFront;

  void setBorderColor(Color color) {
    if (color == _borderColor || !mounted) return;
    _isFront = _flipCardController.state!.isFront;
    setState(() {
      _borderColor = color;
    });
  }

  Future<bool> autoPlay() async {
    try {
      setState(() {
        _isPlaying = true;
      });
      await Future.delayed(const Duration(milliseconds: 1300));
      await _audioButtonController.playAudio();
      await Future.delayed(const Duration(milliseconds: 1000));
      await flipCard();
      await Future.delayed(const Duration(milliseconds: 2000));
      setState(() {
        _isPlaying = false;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: _flipCardController,
      flipOnTouch: !_isPlaying,
      speed: 700,
      front: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: Dimensions.widthRatio(context, 90),
        height: Dimensions.heightRatio(context, 65),
        decoration: BoxDecoration(
          color: const Color(0xFF023E8A),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _isFront ? _borderColor : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x89000000),
              spreadRadius: 0.25,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width12(context),
              ),

              // TODO: handle overflow text
              child: Text(
                widget.word.engWord?.word ?? '',
                style: TextStyle(
                  fontSize: Dimensions.fontSize(context, 70),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightRatio(context, 0.5)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width12(context),
              ),
              child: Text(
                widget.word.engWord?.phonetic ?? '',
                style: TextStyle(fontSize: Dimensions.fontSize20(context)),
              ),
            ),
            SizedBox(height: Dimensions.heightRatio(context, 5)),
            AudioButton(
              key: ValueKey(widget.word.id),
              controller: _audioButtonController,
              word: widget.word.engWord?.word ?? '',
              size: Dimensions.iconSize(context, 100),
              url: widget.word.engWord?.audio ?? '',
            ),
          ],
        ),
      ),
      back: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: Dimensions.widthRatio(context, 90),
        height: Dimensions.heightRatio(context, 65),
        decoration: BoxDecoration(
          color: const Color(0xFF023E8A),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _isFront ? Colors.transparent : _borderColor,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x89000000),
              spreadRadius: 0.25,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.width12(context)),
              child: Text(
                widget.word.userDefinition,
                style: TextStyle(
                  fontSize: Dimensions.fontSize(context, 70),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightRatio(context, 1.0)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width12(context),
              ),
              child: Text(
                widget.word.description ?? '',
                style: TextStyle(
                  fontSize: Dimensions.fontSize20(context),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightRatio(context, 5)),
          ],
        ),
      ),
    );
  }
}
