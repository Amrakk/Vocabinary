import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class UserRepo {
  final _firestoreService = FirestoreService.instance;

  static String collectionPath = 'users';
  static String documentPath(String id) => 'users/$id';

  Future<UserModel?> getUser(String id) => userStream(id).first;

  Future<List<UserModel>> getUsers() => usersStream().first;

  Future<String?> createUser(UserModel data, String userId) => _firestoreService.createData(
        collectionPath: collectionPath,
        data: data.toMap(),
        documentId: userId,
      );

  Future<bool> updateUser(String id, UserModel data) =>
      _firestoreService.updateData(
        documentPath: documentPath(id),
        data: data.toMap(),
      );

  Future<bool> deleteUser(String id) =>
      _firestoreService.deleteData(documentPath: documentPath(id));

  Stream<List<UserModel>> usersStream() =>
      _firestoreService.collectionStream<UserModel>(
        path: collectionPath,
        builder: _builder,
      );

  Stream<UserModel?> userStream(String id) =>
      _firestoreService.documentStream<UserModel?>(
        path: documentPath(id),
        builder: _builder,
      );

  Future<UserModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? UserModel.fromMap(data, documentID) : null;
}
