import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class EngWordRepo {
  final _firestoreService = FirestoreService.instance;

  static String documentPath(String id) => 'engWords/$id';
  static String collectionPath = 'engWords';

  Future<EngWordModel?> getEngWord({String? id, String? path}) {
    assert(id != null || path != null, 'Either id or path must be provided.');
    assert(!(id != null && path != null),
        'Only one of id or path should be provided.');

    return id != null
        ? engWordStream(id: id).first
        : engWordStream(path: path!).first;
  }

  Future<String?> createEngWord(EngWordModel data) =>
      _firestoreService.createData(
        collectionPath: collectionPath,
        data: data.toMap(),
      );

  Future<bool> updateEngWord(String id, Map<String, dynamic> data) =>
      _firestoreService.updateData(
        documentPath: documentPath(id),
        data: data,
      );

  Future<bool> deleteEngWord(String id) =>
      _firestoreService.deleteData(documentPath: documentPath(id));

  Stream<List<EngWordModel>> engWordsStream() =>
      _firestoreService.collectionStream<EngWordModel>(
        path: collectionPath,
        builder: _builder,
      );

  Stream<EngWordModel?> engWordStream({String? id, String? path}) {
    assert(id != null || path != null, 'Either id or path must be provided.');
    assert(!(id != null && path != null),
        'Only one of id or path should be provided.');

    return _firestoreService.documentStream<EngWordModel?>(
      path: id != null ? documentPath(id) : path!,
      builder: _builder,
    );
  }

  Future<EngWordModel?> _builder(
      Map<String, dynamic>? data, String documentID) async {
    return data != null ? EngWordModel.fromMap(data, documentID) : null;
  }
}
