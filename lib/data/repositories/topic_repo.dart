import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class TopicRepo {
  final _firestoreService = FirestoreService.instance;

  static String documentPath(String id) => 'topics/$id';
  static String collectionPath = 'topics';

  Future<TopicModel?> getTopic(String id) => topicStream(id).first;

  Future<List<TopicModel>> getTopics() => topicsStream().first;

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

  Stream<List<TopicModel>> topicsStream() =>
      _firestoreService.collectionStream<TopicModel>(
        path: collectionPath,
        builder: _builder,
      );

  Stream<TopicModel?> topicStream(String id) =>
      _firestoreService.documentStream<TopicModel?>(
        path: documentPath(id),
        builder: _builder,
      );

  Future<TopicModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? TopicModel.fromMap(data, documentID) : null;
}
