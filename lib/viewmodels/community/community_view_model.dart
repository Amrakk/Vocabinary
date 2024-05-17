import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/data/repositories/user_repo.dart';
import 'package:vocabinary/models/data/word.dart';

class CommunityViewModel extends ChangeNotifier {
  List<TopicModel> _topicsPublic = [];
  List<TopicModel> get topicsPublic => _topicsPublic;
  final TopicRepo _topicRepo = TopicRepo();
  final WordRepo _wordRepo = WordRepo();
  final UserRepo _userRepo = UserRepo();

  CommunityViewModel();

  Future<void> getAllTopicPublic() async {
    await _topicRepo.getTopics().then((value) {
      _topicsPublic.clear();
      for (var topic in value) {
        if(topic.isPublic == true) {
          _topicsPublic.add(topic);
        }
      }
    });
    notifyListeners();
  }

  Future<List<WordModel>> getAllWordsByTopic(String topicID) async {
    return await _wordRepo.getWords(topicID);
  }

  Future<bool> isTopicOwner(String id, String userID) async {
    return await _topicRepo.isTopicOwner(id, userID);
  }

  Future<bool> isFollowing(TopicModel topic, String userID) async {
    return topic.followers.contains(userID);
  }

  Future<void> followTopic(TopicModel topic, String userID) async {
    topic.followers.add(userID);
    await _topicRepo.updateTopic(topic.id!, topic);
    notifyListeners();
  }

  Future<UserModel?> getOwner(String ownerID) async {
    return await _userRepo.getUser(ownerID);
  }
  Future<void> unfollowTopic(TopicModel topic, String userID) async {
    topic.followers.remove(userID);
    await _topicRepo.updateTopic(topic.id!, topic);
    notifyListeners();
  }
}
