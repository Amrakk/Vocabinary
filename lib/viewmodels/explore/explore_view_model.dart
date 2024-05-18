import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/folder_repo.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/models/data/user_topic_log.dart';

import '../../data/repositories/user_topic_log_repo.dart';

class ExploreViewModel extends ChangeNotifier {
  final FolderRepo _folderRepo = FolderRepo();
  final TopicRepo _topicRepo = TopicRepo();
  final UserTopicLogRepo _userTopicLogRepo = UserTopicLogRepo();
  String userID;
  List<FolderModel> _folders = [];

  List recentTopics = [];
  List recentTopicsDestination = [];
  List<FolderModel> get folders => _folders;

  // Store the list of topics
  List<TopicModel> _topics = [];

  // Store the current topic
  TopicModel? _currentTopic;

  // Constructor that takes the repository as a parameter
  ExploreViewModel(this.userID);

  // Getter for the list of topics
  List<TopicModel> get topics => _topics;

  // Getter for the current topic
  TopicModel? get currentTopic => _currentTopic;

  // Load topics from the repository and notify listeners
  Future<void> loadTopics() async {
    _topics = await _topicRepo.getTopicsByOwner(userID);
    notifyListeners(); // Notify the UI to update
  }

  Stream<List<TopicModel>> getTopicsStream() {
    print('UserID: $userID');
    return _topicRepo.topicsStream(ownerID: userID);
  }

  Future<void> loadFolders() async {
    print('UserID: $userID');
    _folders = await _folderRepo.getFolders(userID);
    notifyListeners(); // Notify the UI to update
  }

  Future<void> loadRecentActivities() async {
    recentTopics = await _topicRepo.getRecentTopicsForUser(userID, 5);
    notifyListeners(); // Notify the UI to update
  }

  Future<void> loadRecentActivitiesDestination() async {
    recentTopicsDestination = await getTopicSaveDestination();
    notifyListeners(); // Notify the UI to update
  }

  Future<List> getTopicSaveDestination() async{
    //return folder destination name of the topics
    await loadRecentActivities();
    List<String> destination = [];
    for (var topic in recentTopics) {
      var topicID = topic.id;
      var folder = await _folderRepo.getFolderByTopicID(userID, topicID);
      if(folder.name != null)
      {
        destination.add(folder.name!);
      }else{
        destination.add('No Folder');
      }
    }
    return destination;
  }

  Stream<List<FolderModel>> getFoldersStream() {
    return _folderRepo.foldersStream(userID);
  }

  Stream<List<FolderModel>> getFoldersStreamByTopicNum(int numberOfTopics) {
    return _folderRepo.foldersStream(userID).map((folders) {
      return folders.where((folder) => folder.topicIDs.length > numberOfTopics).toList();
    });
  }

  Future<void> createFolder(FolderModel data) async {
    await _folderRepo.createFolder(userID, data);
  }

  Future<void> updateFolder(String id, FolderModel data) async {
    await _folderRepo.updateFolder(userID, id, data);
  }

  Future<void> deleteFolder(String id) async {
    await _folderRepo.deleteFolder(userID, id);
  }

  // Load a specific topic from the repository and notify listeners
  Future<void> loadTopic(String id) async {
    _currentTopic = await _topicRepo.getTopic(id);
    notifyListeners(); // Notify the UI to update
  }

  // Create a new topic and update the topics list
  Future<void> createTopic(TopicModel data) async {
    final id = await _topicRepo.createTopic(data);
    if (id != null) {
      // Reload topics to include the newly created topic
      await loadTopics();
    }
  }

  // Update an existing topic and refresh the topics list
  Future<void> updateTopic(String id, TopicModel data) async {
    final success = await _topicRepo.updateTopic(id, data);
    if (success) {
      // Reload topics to reflect the updated topic
      await loadTopics();
    }
  }

  // Delete a topic and refresh the topics list
  Future<void> deleteTopic(String id) async {
    final success = await _topicRepo.deleteTopic(id);
    if (success) {
      // Reload topics to remove the deleted topic
      await loadTopics();
    }
  }
}