class FolderModel {
  String? id;
  String? name;
  List<String> topicRefs;

  FolderModel({
    this.id,
    this.name,
    this.topicRefs = const [],
  });

  factory FolderModel.fromMap(Map<String, dynamic> map, String id) {
    return FolderModel(
      id: id,
      name: map['name'],
      topicRefs: List<String>.from(map['topicRefs'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'topics': topicRefs,
    };
  }

  @override
  String toString() {
    return 'FolderModel{id: $id, name: $name, topics: $topicRefs}';
  }
}
