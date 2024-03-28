import 'package:vocabinary/models/data/topic.dart';

class FolderModel {
  String? id;
  String? name;
  List<TopicModel>? topics = [];

  FolderModel({
    this.id,
    this.name,
  });

  factory FolderModel.fromMap(Map<String, dynamic> map, String id) {
    return FolderModel(
      id: id,
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
