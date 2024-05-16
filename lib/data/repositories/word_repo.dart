import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/services/api/dict_api.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class WordRepo {
  final _firestoreService = FirestoreService.instance;
  final DictApi _dictApi = DictApi();

  static String collectionPath(String topicID) => 'topics/$topicID/words';
  static String documentPath(String topicID, String id) =>
      'topics/$topicID/words/$id';

  Future<WordModel?> getWord(String topicID, String id) =>
      wordStream(topicID, id).first;

  Future<List<WordModel>> getWords(String topicID) =>
      wordsStream(topicID).first;

  Future<String?> createWord(String topicID, WordModel data) =>
      _firestoreService.createData(
        collectionPath: collectionPath(topicID),
        data: data.toMap(),
      );

  Future<EngWordModel> getDataFromAPI(String word) {
    return _dictApi.getApiData(word);
  }

  Future<bool> updateWord(
    String topicID,
    String id,
    WordModel data,
  ) =>
      _firestoreService.updateData(
        documentPath: documentPath(topicID, id),
        data: data.toMap(),
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
    Map<String, dynamic>? data,
    String documentID,
  ) async {
    if (data == null) return null;

    final wordModel = WordModel.fromMap(data, documentID);
    await wordModel.loadEngWord;
    return wordModel;
  }
}
