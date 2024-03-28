import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class WordRepo {
  final _firestoreService = FirestoreService.instance;

  static String documentPath(String topicID, String id) =>
      'topics/$topicID/words/$id';
  static String collectionPath(String topicID) => 'topics/$topicID/words';

  Future<WordModel?> getWord(String topicID, String id) =>
      wordStream(topicID, id).first;

  Future<String?> createWord(String topicID, Map<String, dynamic> data) =>
      _firestoreService.createData(
        collectionPath: collectionPath(topicID),
        data: data,
      );

  Future<bool> updateWord(
    String topicID,
    String id,
    Map<String, dynamic> data,
  ) =>
      _firestoreService.updateData(
        documentPath: documentPath(topicID, id),
        data: data,
      );

  Future<bool> deleteWord(String topicID, String id) =>
      _firestoreService.deleteData(documentPath: documentPath(topicID, id));

  Stream<List<WordModel>> wordsStream(String topicID) =>
      _firestoreService.collectionStream<WordModel>(
        path: collectionPath(topicID),
        builder: _builder,
      );

  Stream<WordModel?> wordStream(String topicID, String id) =>
      _firestoreService.documentStream<WordModel?>(
        path: documentPath(topicID, id),
        builder: _builder,
      );

  Future<WordModel?> _builder(
      Map<String, dynamic>? data, String documentID) async {
    if (data == null) return null;
    final wordModel = WordModel.fromMap(data, documentID);
    await wordModel.loadEngWord;
    return wordModel;
  }
}
