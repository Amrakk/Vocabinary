import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/models/data/word.dart';

import '../data/repositories/topic_repo.dart';
import '../models/data/topic.dart';

class HomePageViewModel extends ChangeNotifier {
  final _wordRepo = WordRepo();
  final _topicRepo = TopicRepo();
  List<WordModel> _words = [];
  List<WordModel> get words => _words;
  String userID;
  List<TopicModel> _topics = [];

  HomePageViewModel(this.userID);

  Future<void> loadTopics() async {
    _topics = await _topicRepo.getTopicsByOwner(userID);
    notifyListeners();
  }

  Future<void> getWords() async{
    List<WordModel> _allWords = [];
    await loadTopics();
    for (var topic in _topics) {
      var words = await _wordRepo.getWords(topic.id!);
      for(var word in words){
        _allWords.add(word);
      }
    }
    _words = _allWords;
    print(_words);
  }
}
