import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';

import '../../data/repositories/eng_word_repo.dart';
import '../../data/repositories/word_repo.dart';
import '../../models/data/eng_word.dart';
import '../../models/data/word.dart';

class CreateWordViewModel extends ChangeNotifier{
  final WordRepo _wordRepo = WordRepo();
  final EngWordRepo _engWordRepo = EngWordRepo();
  final TopicRepo _topicRepo = TopicRepo();
  List<EngWordModel> _engWords = [];
  List<EngWordModel> get engWords => _engWords;

  final List<String> topics;
  CreateWordViewModel({required this.topics});

  Future<void> addWord(WordModel word) async {
    List<Future> futures = [];

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
    for(var topic in topics){
      futures.add(_wordRepo.createWord(topic, word));
      var topicModel = await _topicRepo.getTopic(topic);
      topicModel?.wordCount++;
      futures.add(_topicRepo.updateTopic(topic, topicModel!));
    }
    notifyListeners();
  }

}