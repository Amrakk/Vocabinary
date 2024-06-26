import 'package:vocabinary/data/repositories/user_repo.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/models/data/user_topic_log.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/data/repositories/user_topic_log_repo.dart';

class TopicModel {
  int level;
  String? id;
  String? name;
  int wordCount;
  bool isPublic;
  String? ownerID;
  String? description;
  Timestamp? createdAt;
  List<String> followers;
  String? imageTopic;

  List<WordModel> words;
  List<UserTopicLogModel> userLogs;

  TopicModel({
    this.id,
    this.name,
    this.ownerID,
    this.level = 1,
    this.wordCount = 0,
    this.isPublic = false,
    this.description,
    this.createdAt,
    this.imageTopic,
    this.words = const [],
    this.userLogs = const [],
    this.followers = const [],
  });

  Future<void> get loadWords async {
    assert(id != null, 'Topic ID should not be null');
    words = await WordRepo().getWords(id!);
  }

  Future<void> get loadUserLogs async {
    assert(id != null, 'Topic ID should not be null');
    userLogs = await UserTopicLogRepo().getUserTopicLogs(id!);
    await Future.wait(userLogs.map((e) => e.loadLearnings(id!)));
  }

  Future<UserModel?> get getOwner async {
    assert(ownerID != null, 'Owner ID should not be null');
    return await UserRepo().getUser(ownerID!);
  }

  Future<List<UserModel>> get getFollowers async {
    if (followers.isEmpty) return [];
    var users = <UserModel>[];

    for (var userID in followers) {
      var user = await UserRepo().getUser(userID);
      if (user != null) users.add(user);
    }

    return users;
  }

  factory TopicModel.fromMap(Map<String, dynamic> map, String id) {
    return TopicModel(
      id: id,
      name: map['name'],
      ownerID: map['ownerID'],
      level: map['level'] ?? 1,
      wordCount: map['wordCount'] ?? 0,
      isPublic: map['isPublic'] ?? false,
      description: map['description'],
      createdAt: map['createdAt'],
      imageTopic: map['imageTopic'],
      followers: List<String>.from(map['followers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'ownerID': ownerID,
      'isPublic': isPublic,
      'wordCount': wordCount,
      'description': description,
      'createdAt': createdAt,
      'followers': followers,
      'imageTopic': imageTopic,
    };
  }

  //dd/mm/yyy format
  String get createdAtString {
    if (createdAt == null) return '';
    return '${createdAt!.toDate().day}/${createdAt!.toDate().month}/${createdAt!.toDate().year}';
  }

  @override
  String toString() {
    return 'Topic{id: $id, name: $name, level: $level, wordCount: $wordCount, isPublic: $isPublic, ownerID: $ownerID, description: $description,createdAt: $createdAt}';
  }
}
