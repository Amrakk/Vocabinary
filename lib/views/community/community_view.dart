import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/routes/routes.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: ()async{
        //route to learning
        Navigator.pushNamed(context, AppRoutes.learningRoutes[2]);
      }, child: Text('FlashCard')),
    );
  }
}
