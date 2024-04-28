import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  /// Return the document `id` after adding the data to the collection. Otherwise, return `null`.
  // Future<String?> createData<T>({
  //   required String collectionPath,
  //   required Map<String, dynamic> data,
  // }) async {
  //   final reference = FirebaseFirestore.instance.collection(collectionPath);
  //   return await reference
  //       .add(data)
  //       .then<String?>((value) => value.id)
  //       .catchError((_) => null);
  // }

  Future<String?> createData<T>({
    required String collectionPath,
    String? documentId,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(collectionPath);
    DocumentReference docRef;
    if (documentId != null) {
      docRef = reference.doc(documentId);
      await docRef.set(data);
    } else {
      docRef = await reference.add(data);
    }
    return docRef.id;
  }


  /// Return `true` if the data is updated successfully. Otherwise, return `false`.
  ///
  /// NOTE: If the document does not exist, the method will return `false`.
  Future<bool> updateData<T>({
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(documentPath);
    return await reference
        .update(data)
        .then((_) => true)
        .catchError((_) => false);
  }

  /// Return `true` if the data is deleted successfully. Otherwise, return `false`.
  ///
  /// NOTE: If the document does not exist, the method will return `true`.
  ///
  /// WARNING: Deleting a document does not delete its subcollections!
  Future<bool> deleteData({required String documentPath}) async {
    final reference = FirebaseFirestore.instance.doc(documentPath);
    return await reference.delete().then((_) => true).catchError((_) => false);
  }

  /// Return the collection as a `Stream<List<T>>` if the collection exists.
  ///
  /// NOTE: If the collection does not exist, the stream will not emit any items.
  Stream<List<T>> collectionStream<T>({
    required String path,
    required Future<T?> Function(Map<String, dynamic>? data, String documentID)
        builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.asyncMap((snapshot) async {
      var list = await Future.wait(
        snapshot.docs
            .map((snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>?, snapshot.id))
            .toList(),
      );
      list.removeWhere((element) => element == null);

      var result = list.map((e) => e!).toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  /// Return the document as a `Stream<T>` if the document exists
  ///
  /// NOTE: If the document does not exist, the stream will not emit any items.
  Stream<T> documentStream<T>({
    required String path,
    required Future<T> Function(Map<String, dynamic>? data, String documentID)
        builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.asyncMap((snapshot) async =>
        await builder(snapshot.data() as Map<String, dynamic>?, snapshot.id));
  }

  /// Set the data at the specified path. If `merge` is `true`, the data will be merged with the existing data.
  /// If the document does not exist, it will be created.
  /// If the data is successfully set, return `true`. Otherwise, return `false`.
  ///
  /// NOTE: Try to use `createData` and `updateData` instead of this method for better readability.
  /// Use this method only for more complex operations or overriding the default behavior.
  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }
}
