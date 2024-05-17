import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/data/repositories/user_topic_log_repo.dart';
import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

import '../../models/data/user_topic_log.dart';

class TopicRepo {
  final _firestoreService = FirestoreService.instance;

  static String documentPath(String id) => 'topics/$id';
  static String collectionPath = 'topics';


  Future<bool> isTopicOwner(String id, String userID) async =>
      (await getTopic(id))?.ownerID == userID;

  Future<TopicModel?> getTopic(String id) => topicStream(id).first;

  Future<List<TopicModel>> getTopics() => topicsStream().first;

  Future<List<TopicModel>> getTopicsByOwner(String ownerID) => topicsStream(ownerID: ownerID).first;

  Future<List> getRecentTopics(String ownerID) => getRecentTopicsForUser(ownerID, 5);

  Future<void> decreaseWordCount(String id) async {
    TopicModel? topic = await getTopic(id);
    if (topic != null) {
      topic.wordCount--;
      await updateTopic(id, topic);
    }
  }

  Future<String?> createTopic(TopicModel data) => _firestoreService.createData(
        collectionPath: collectionPath,
        data: data.toMap(),
      );

  Future<bool> updateTopic(String id, TopicModel data) =>
      _firestoreService.updateData(
        documentPath: documentPath(id),
        data: data.toMap(),
      );

  Future<bool> deleteTopic(String id) =>
      _firestoreService.deleteData(documentPath: documentPath(id));

  Stream<List<TopicModel>> topicsStream({String? ownerID}) {
    return _firestoreService.collectionStream<TopicModel>(
      path: collectionPath,
      builder: _builder,
      queryBuilder: ownerID != null ? (query) => query.where('ownerID', isEqualTo: ownerID) : null
    );
  }


  Future<List> getRecentTopicsForUser(String userID,int limit) async {
    UserTopicLogRepo userTopicLogRepo = UserTopicLogRepo();
    // Initialize a list to hold the combined data of topics and user logs
    List<Map<String, dynamic>> recentTopicsWithLogs = [];

    // Fetch all topics from the repository
    List<TopicModel> topics = await getTopics();

    // Iterate through each topic and fetch the user log for the specific user and topic
    for (TopicModel topic in topics) {
      // Fetch the user log for the specific topic and user
      UserTopicLogModel? userLog = await userTopicLogRepo.getUserTopicLogByUserID(topic.id!, userID);

      // Check if a user log was found
      if (userLog != null) {
        // Combine the topic data and the user log data
        recentTopicsWithLogs.add({
          'topic': topic,
          'userLog': userLog,
        });
      }
    }

    // Sort the combined data list by the lastAccess field of the user log in descending order
    recentTopicsWithLogs.sort((a, b) => b['userLog'].lastAccess.compareTo(a['userLog'].lastAccess));

    // Limit the list to the specified number of recent topics (e.g. 5)
    recentTopicsWithLogs = recentTopicsWithLogs.take(limit).toList();

    // Extract the topics from the list and return them
    return recentTopicsWithLogs.map((e) => e['topic']).toList();
  }

  Stream<TopicModel?> topicStream(String id) =>
      _firestoreService.documentStream<TopicModel?>(
        path: documentPath(id),
        builder: _builder,
      );

  Query ownerIDFilter(Query query, String ownerID) {
    return query.where('ownerID', isEqualTo: ownerID);
  }

  Future<TopicModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? TopicModel.fromMap(data, documentID) : null;
}
