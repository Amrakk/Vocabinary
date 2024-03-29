import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/models/data/topic.dart';

class FolderModel {
  String? id;
  String? name;
  List<String> topicIDs;

  FolderModel({
    this.id,
    this.name,
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
      topicIDs: List<String>.from(map['topics'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'topics': topicIDs,
    };
  }

  @override
  String toString() {
    return 'FolderModel{id: $id, name: $name, topics: $topicIDs}';
  }
}
