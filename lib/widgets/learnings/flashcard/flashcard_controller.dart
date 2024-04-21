import 'package:flutter/material.dart';
import 'package:vocabinary/widgets/learnings/flashcard/flashcard.dart';

class FlashcardController {
  FlashcardState? state;

  bool isFront() => state!.isFront;

  Future<void> flipCard() => state!.flipCard();

  Future<bool?> autoPlay() => state!.autoPlay();

  void setBorderColor(Color color) => state!.setBorderColor(color);
}
