import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/word.dart';

class TypingView extends StatefulWidget {
  final String topicID;
  final List<WordModel> words;

  const TypingView({super.key, required this.topicID, required this.words});

  @override
  State<TypingView> createState() => _TypingViewState();
}

class _TypingViewState extends State<TypingView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
