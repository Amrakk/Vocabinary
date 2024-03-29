import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/models/data/user_topic_log.dart';
import 'package:vocabinary/models/data/word.dart';

class TopicModel {
  String? id;
  String? name;
  String? ownerID;
  int wordCount;
  bool isPublic;
  Timestamp? createdAt;
  List<String> followers;
  List<WordModel> words;
  List<UserTopicLogModel> userLogs;

  TopicModel({
    this.id,
    this.name,
    this.ownerID,
    this.wordCount = 0,
    this.isPublic = false,
    this.createdAt,
    this.words = const [],
    this.userLogs = const [],
    this.followers = const [],
  });

  Future<void> get loadWords async {
    assert(id == null, 'Topic ID is null');
    words = await WordRepo().getWords(id!);
  }

  factory TopicModel.fromMap(Map<String, dynamic> map, String id) {
    return TopicModel(
      id: id,
      name: map['name'],
      ownerID: map['ownerID'],
      wordCount: map['wordCount'] ?? 0,
      isPublic: map['isPublic'] ?? false,
      createdAt: map['createdAt'],
      followers: List<String>.from(map['followers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerID': ownerID,
      'wordCount': wordCount,
      'isPublic': isPublic,
      'createdAt': createdAt,
      'followers': followers,
    };
  }

  @override
  String toString() {
    return 'TopicModel{id: $id, name: $name, ownerID: $ownerID, wordCount: $wordCount, isPublic: $isPublic, createdAt: $createdAt, followers: $followers}';
  }
}
