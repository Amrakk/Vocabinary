import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<UserTopicLogModel?> getUserTopicLogByUserID(
      String topicID,
      String userID,
      ) async {
    final userTopicLogs = await getUserTopicLogs(topicID);
    try {
      return userTopicLogs.firstWhere((element) => element.userID == userID);
    } catch (e) {
      return null;
    }
  }

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

  Future<UserTopicLogModel?> getMostRecentUserLog(String topicID, String userID) async {
    // Define the path to the user log subcollection for the specific topic
    final userLogPath = UserTopicLogRepo.collectionPath(topicID);

    // Query the subcollection for entries that match the user ID and order by lastAccess in descending order
    Query query = FirebaseFirestore.instance.collection(userLogPath)
        .where('userID', isEqualTo: userID)
        .orderBy('lastAccess', descending: true)
        .limit(5); // Limit to 1 entry to get the most recent one

    // Execute the query and get the snapshot
    QuerySnapshot snapshot = await query.get();

    // If there is at least one document in the snapshot, return the most recent user log
    if (snapshot.docs.isNotEmpty) {
      // Get the first document
      var document = snapshot.docs.first;

      // Ensure data is in the expected format
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      // If data is null, return null
      if (data == null) {
        return null;
      }

      // Create and return the model
      return UserTopicLogModel.fromMap(data, document.id);
    }

    // Return null if no documents were found
    return null;
  }

  Future<UserTopicLogModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? UserTopicLogModel.fromMap(data, documentID) : null;
}
