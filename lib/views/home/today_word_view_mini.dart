import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocabinary/viewmodels/home_view_model.dart';
import 'package:vocabinary/widgets/home/card_vocabulary.dart';

import '../../models/data/word.dart';
import '../../services/firebase/authentication_service.dart';

class TodayWorldView extends StatefulWidget {
  const TodayWorldView({super.key});

  @override
  State<TodayWorldView> createState() {
    return _TodayWorldViewState();
  }
}

class _TodayWorldViewState extends State<TodayWorldView> {
  late Future<void> _loadVocabularyFuture;
  late HomePageViewModel _homePageViewModel;

  @override
  void initState() {
    AuthenticationService _authenticationService =
        AuthenticationService.instance;
    String uid = _authenticationService.currentUser?.uid ?? '';
    _homePageViewModel = HomePageViewModel("4VtPfzFkETVqg29YJdpW");
    _loadVocabularyFuture = _homePageViewModel.getWords();
    super.initState();
  }

  //func get 3 random word that not duplicated
  List<WordModel> getRandomWords(List<WordModel> words, int count) {
    List<WordModel> randomWords = [];
    for (int i = 0; i < count; i++) {
      int randomIndex = Random().nextInt(words.length);
      if (!randomWords.contains(words[randomIndex])) {
        randomWords.add(words[randomIndex]);
      } else {
        i--;
      }
    }
    return randomWords;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _loadVocabularyFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else {
                List<WordModel> words = _homePageViewModel.words;
                if(words.length == 0){
                  return const Text('No word added yet.');
                }else{
                  List<WordModel> randomWords = getRandomWords(words, 3);
                  return Column(
                    children: [
                      CardVocabulary(word: randomWords[0]),
                      const SizedBox(height: 20),
                      CardVocabulary(word: randomWords[1]),
                      const SizedBox(height: 20),
                      CardVocabulary(word: randomWords[2]),
                      const SizedBox(height: 20),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
