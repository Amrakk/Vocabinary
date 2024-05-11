import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/eng_word_repo.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/models/data/eng_word.dart';

import '../../models/data/word.dart';

class WordViewModel extends ChangeNotifier{
  final WordRepo _wordRepo = WordRepo();
  final EngWordRepo _engWordRepo = EngWordRepo();
  final String topicID;

  List<EngWordModel> _engWords = [];
  List<EngWordModel> get engWords => _engWords;

  List<WordModel> _words = [];
  List<WordModel> get words => _words;

  WordViewModel({required this.topicID});

  Future<void> getWords() async {
    _words = await _wordRepo.getWords(topicID);
    notifyListeners();
  }

  //get engWord base on wordID
  Future<void> getEngWords() async {
    //get engWord from word
    await getWords();
    for (var word in _words) {
      var engWord = await _engWordRepo.getEngWord(word.engWord?.id ?? '');
      if (engWord != null) {
        _engWords.add(engWord);
      }
    }
    notifyListeners();
  }
}