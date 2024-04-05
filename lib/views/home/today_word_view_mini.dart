import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/home/card_vocabulary.dart';

class TodayWorldView extends StatefulWidget {
  const TodayWorldView({super.key});

  @override
  State<TodayWorldView> createState() {
    return _TodayWorldViewState();
  }
}

class _TodayWorldViewState extends State<TodayWorldView> {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardVocabulary(),
              SizedBox(height: 20),
              CardVocabulary(),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
