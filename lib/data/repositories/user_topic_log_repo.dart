import 'package:vocabinary/models/data/user_topic_log.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class UserTopicLogRepo {
  final _firestoreService = FirestoreService.instance;

  static String collectionPath(String topicID) => 'topics/$topicID/userLogs';
  static String documentPath(String topicID, String id) =>
      'topics/$topicID/userLogs/$id';

  Future<UserTopicLogModel?> getUserTopicLog(String topicID, String id) =>
      userTopicLogStream(topicID, id).first;

  Future<List<UserTopicLogModel>> getUserTopicLogs(String topicID) =>
      userTopicLogsStream(topicID).first;

  Future<String?> createUserTopicLog(String topicID, UserTopicLogModel data) =>
      _firestoreService.createData(
        collectionPath: collectionPath(topicID),
        data: data.toMap(),
      );

  Future<bool> updateUserTopicLog(
          String topicID, String id, UserTopicLogModel data) =>
      _firestoreService.updateData(
        documentPath: documentPath(topicID, id),
        data: data.toMap(),
      );

  Future<bool> deleteUserTopicLog(String topicID, String id) =>
      _firestoreService.deleteData(documentPath: documentPath(topicID, id));

  Stream<List<UserTopicLogModel>> userTopicLogsStream(String topicID) =>
      _firestoreService.collectionStream<UserTopicLogModel>(
        path: collectionPath(topicID),
        builder: _builder,
      );

  Stream<UserTopicLogModel?> userTopicLogStream(String topicID, String id) =>
      _firestoreService.documentStream<UserTopicLogModel?>(
        path: documentPath(topicID, id),
        builder: _builder,
      );

  Future<UserTopicLogModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? UserTopicLogModel.fromMap(data, documentID) : null;
}
