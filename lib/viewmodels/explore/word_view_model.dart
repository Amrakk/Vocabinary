import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/eng_word_repo.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/models/data/eng_word.dart';

import '../../models/data/word.dart';

class WordViewModel extends ChangeNotifier{
  final WordRepo _wordRepo = WordRepo();
  final EngWordRepo _engWordRepo = EngWordRepo();
  final TopicRepo _topicRepo = TopicRepo();
  final String topicID;

  List<EngWordModel> _engWords = [];
  List<EngWordModel> get engWords => _engWords;

  List<WordModel> _words = [];
  List<WordModel> get words => _words;
  EngWordModel _apiData = EngWordModel();
  EngWordModel get apiData => _apiData;

  WordViewModel([this.topicID = '']);



  Future<void> getWords() async {
    _words = await _wordRepo.getWords(topicID);
    notifyListeners();
  }

  Future<void> deleteWord(String wordID) async {
    await _wordRepo.deleteWord(topicID, wordID);
    _topicRepo.decreaseWordCount(topicID);
    notifyListeners();
  }

  Future<void> updateWord(WordModel word) async {
    _engWords = await _engWordRepo.getEngWords();
    var eWord = word.engWord?.word;
    var eWordList = _engWords.where((element) => element.word == eWord);
    if (eWordList.isNotEmpty) {
      word.engWord = eWordList.first;
      word.updateEngWordID(eWordList.first.id!);
    } else {
      var engWord = EngWordModel(word: eWord,phonetic: word.engWord!.phonetic,audio: word.engWord!.audio);
      var id = await _engWordRepo.createEngWord(engWord);
      word.updateEngWordID(id!);
    }
    await _wordRepo.updateWord(topicID,word.id!, word);
    notifyListeners();
  }

  Future<void> getPhonetic(String word) async {
    var engWord = await _wordRepo.getDataFromAPI(word);
    if (engWord.phonetic != null) {
      _apiData = engWord;
    }
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

  Stream<List<WordModel>> getWordsStream(String topicID) {
    return _wordRepo.wordsStream(topicID);
  }
}