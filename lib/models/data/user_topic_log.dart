import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/models/data/learning.dart';

class UserTopicLogModel {
  String? id;
  String? userID;
  int learnedCount;
  Timestamp? lastAccess;
  List<LearningModel> learnings;

  UserTopicLogModel({
    this.id,
    this.userID,
    this.learnedCount = 0,
    this.lastAccess,
    this.learnings = const [],
  });

  Future<void> loadLearnings() async {
    assert(id == null, 'UserTopicLog ID is null');
    // learnings = await LearningRepo().getLearnings(id!);
  }

  factory UserTopicLogModel.fromMap(Map<String, dynamic> map, String id) {
    return UserTopicLogModel(
      id: id,
      userID: map['userID'],
      learnedCount: map['learnedCount'] ?? 0,
      lastAccess: map['lastAccess'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'learnedCount': learnedCount,
      'lastAccess': lastAccess,
    };
  }

  @override
  String toString() {
    return 'UserTopicLog{id: $id, userID: $userID, learnedCount: $learnedCount, lastAccess: $lastAccess}';
  }
}
