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

  Future<List<Map<String, dynamic>>> get recentActivities => fetchRecentlyAccessedTopicsForUser();

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

  Future<void> loadFolders() async {
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

  Future<List<Map<String, dynamic>>> fetchRecentlyAccessedTopicsForUser() async {
    // Initialize a list to hold the combined data of topics and user logs
    List<Map<String, dynamic>> recentTopics = [];

    // Fetch all topics from the repository
    List<TopicModel> topics = await _topicRepo.getTopics();

    // Iterate through each topic and fetch the most recent user log for the specific user
    for (TopicModel topic in topics) {
      // Fetch the most recent user log for the specific topic and user
      UserTopicLogModel? recentUserLog = await _userTopicLogRepo.getMostRecentUserLog(topic.id!, userID);

      // Check if a recent user log was found
      if (recentUserLog != null) {
        // Combine the topic data and the recent user log data
        recentTopics.add({
          'topic': topic,
          'recentUserLog': recentUserLog
        });
      }
    }

    // Sort the list of recent topics by the lastAccess field of the recent user log in descending order
    recentTopics.sort((a, b) => b['recentUserLog'].lastAccess.compareTo(a['recentUserLog'].lastAccess));

    // Limit the list to the number of recent topics you want to display (e.g. 5)
    int limit = 5;
    if (recentTopics.length > limit) {
      recentTopics = recentTopics.sublist(0, limit);
    }

    // Return the sorted and limited list of recent topics
    return recentTopics;
  }

  Future<List> getTopicSaveDestination() async{
    //return folder destination name of the topics
    await loadRecentActivities();
    List<String> destination = [];
    for (var topic in recentTopics) {
      var topicID = topic.id;
      var folder = await _folderRepo.getFolderByTopicID(userID, topicID);
      destination.add(folder.name!);
    }
    return destination;
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

  void init() async{
    await loadTopics();
    await loadFolders();
    await fetchRecentlyAccessedTopicsForUser();
  }
}