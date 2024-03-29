import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class EngWordRepo {
  final _firestoreService = FirestoreService.instance;

  static String collectionPath = 'engWords';
  static String documentPath(String id) => 'engWords/$id';

  Future<EngWordModel?> getEngWord(String id) => engWordStream(id).first;

  Future<List<EngWordModel>> getEngWords() => engWordsStream().first;

  Future<String?> createEngWord(EngWordModel data) =>
      _firestoreService.createData(
        collectionPath: collectionPath,
        data: data.toMap(),
      );

  Future<bool> updateEngWord(String id, EngWordModel data) =>
      _firestoreService.updateData(
        documentPath: documentPath(id),
        data: data.toMap(),
      );

  Future<bool> deleteEngWord(String id) =>
      _firestoreService.deleteData(documentPath: documentPath(id));

  Stream<List<EngWordModel>> engWordsStream() =>
      _firestoreService.collectionStream<EngWordModel>(
        path: collectionPath,
        builder: _builder,
      );

  Stream<EngWordModel?> engWordStream(String id) =>
      _firestoreService.documentStream<EngWordModel?>(
        path: documentPath(id),
        builder: _builder,
      );

  Future<EngWordModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? EngWordModel.fromMap(data, documentID) : null;
}
