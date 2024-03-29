import 'package:vocabinary/models/data/learning_type.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class LearningTypeRepo {
  final _firestoreService = FirestoreService.instance;

  static String collectionPath = 'learningTypes';
  static String documentPath(String id) => 'learningTypes/$id';

  Future<String?> createLearningType(LearningTypeModel data) =>
      _firestoreService.createData(
        collectionPath: collectionPath,
        data: data.toMap(),
      );

  Future<bool> updateLearningType(String id, LearningTypeModel data) =>
      _firestoreService.updateData(
        documentPath: documentPath(id),
        data: data.toMap(),
      );

  Future<bool> deleteLearningType(String id) =>
      _firestoreService.deleteData(documentPath: documentPath(id));

  Stream<List<LearningTypeModel>> learningTypesStream() =>
      _firestoreService.collectionStream<LearningTypeModel>(
        path: collectionPath,
        builder: _builder,
      );

  Stream<LearningTypeModel?> learningTypeStream(String id) =>
      _firestoreService.documentStream<LearningTypeModel?>(
        path: documentPath(id),
        builder: _builder,
      );

  Future<LearningTypeModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? LearningTypeModel.fromMap(data, documentID) : null;
}
