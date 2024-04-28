import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/models/data/topic.dart';

class FolderModel {
  String? id;
  String? name;
  String? ownerID;
  Timestamp? createdAt;
  List<String> topicIDs;

  FolderModel({
    this.id,
    this.name,
    this.ownerID,
    this.createdAt,
    this.topicIDs = const [],
  });

  Future<List<TopicModel>> get getTopics async {
    assert(id != null, 'Folder ID should not be null');

    if (topicIDs.isEmpty) return [];
    var topics = <TopicModel>[];

    for (var topicID in topicIDs) {
      var topic = await TopicRepo().getTopic(topicID);
      if (topic != null) topics.add(topic);
    }

    return topics;
  }

  factory FolderModel.fromMap(Map<String, dynamic> map, String id) {
    return FolderModel(
      id: id,
      name: map['name'],
      ownerID: map['ownerID'],
      createdAt: map['createdAt'],
      topicIDs: List<String>.from(map['topics'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerID': ownerID,
      'createdAt': createdAt,
      'topics': topicIDs,
    };
  }

  //DD/MM/YYYY
  String get createdAtFormatted {
    if (createdAt == null) return '';
    return '${createdAt!.toDate().day}/${createdAt!.toDate().month}/${createdAt!.toDate().year}';
  }

  @override
  String toString() {
    return 'FolderModel{id: $id, name: $name, ownerID: $ownerID, createdAr: $createdAt,topics: $topicIDs}';
  }
}
