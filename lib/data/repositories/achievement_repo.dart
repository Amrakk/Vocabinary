import 'package:vocabinary/models/data/achievement.dart';
import 'package:vocabinary/services/firebase/firestore_service.dart';

class AchievementRepo {
  final _firestoreService = FirestoreService.instance;

  static String collectionPath = 'achievements';
  static String documentPath(String id) => 'achievements/$id';

  Future<AchievementModel?> getAchievement(String id) =>
      achievementStream(id).first;

  Future<List<AchievementModel>> getAchievements() =>
      achievementsStream().first;

  Future<String?> createAchievement(AchievementModel data) =>
      _firestoreService.createData(
        collectionPath: collectionPath,
        data: data.toMap(),
      );

  Future<bool> updateAchievement(String id, AchievementModel data) =>
      _firestoreService.updateData(
        documentPath: documentPath(id),
        data: data.toMap(),
      );

  Future<bool> deleteAchievement(String id) =>
      _firestoreService.deleteData(documentPath: documentPath(id));

  Stream<List<AchievementModel>> achievementsStream() =>
      _firestoreService.collectionStream<AchievementModel>(
        path: collectionPath,
        builder: _builder,
      );

  Stream<AchievementModel?> achievementStream(String id) =>
      _firestoreService.documentStream<AchievementModel?>(
        path: documentPath(id),
        builder: _builder,
      );

  Future<AchievementModel?> _builder(
    Map<String, dynamic>? data,
    String documentID,
  ) async =>
      data != null ? AchievementModel.fromMap(data, documentID) : null;
}
