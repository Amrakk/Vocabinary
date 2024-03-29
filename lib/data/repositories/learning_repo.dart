import 'package:vocabinary/models/data/learning.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class LearningRepo {
  final _firestoreService = FirestoreService.instance;

  static String collectionPath(String topicID, String userTopicLogID) =>
      'topics/$topicID/userLogs/$userTopicLogID/learnings';
  static String documentPath(
          String topicID, String userTopicLogID, String id) =>
      'topics/$topicID/userLogs/$userTopicLogID/learnings/$id';

  Future<LearningModel?> getLearning(
    String topicID,
    String userTopicLogID,
    String id,
  ) =>
      learningStream(topicID, userTopicLogID, id).first;

  Future<List<LearningModel>> getLearnings(
    String topicID,
    String userTopicLogID,
  ) =>
      learningsStream(topicID, userTopicLogID).first;

  Future<String?> createLearning(
    String topicID,
    String userTopicLogID,
    LearningModel data,
  ) =>
      _firestoreService.createData(
        collectionPath: collectionPath(topicID, userTopicLogID),
        data: data.toMap(),
      );

  Future<bool> updateLearning(
    String topicID,
    String userTopicLogID,
    String id,
    LearningModel data,
  ) =>
      _firestoreService.updateData(
        documentPath: documentPath(topicID, userTopicLogID, id),
        data: data.toMap(),
      );

  Future<bool> deleteLearning(
    String topicID,
    String userTopicLogID,
    String id,
  ) =>
      _firestoreService.deleteData(
        documentPath: documentPath(topicID, userTopicLogID, id),
      );

  Stream<List<LearningModel>> learningsStream(
    String topicID,
    String userTopicLogID,
  ) =>
      _firestoreService.collectionStream<LearningModel>(
        path: collectionPath(topicID, userTopicLogID),
        builder: _builder,
      );

  Stream<LearningModel?> learningStream(
    String topicID,
    String userTopicLogID,
    String id,
  ) =>
      _firestoreService.documentStream<LearningModel?>(
        path: documentPath(topicID, userTopicLogID, id),
        builder: _builder,
      );

  Future<LearningModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? LearningModel.fromMap(data, documentID) : null;
}
