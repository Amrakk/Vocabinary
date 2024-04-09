import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/data/repositories/eng_word_repo.dart';

class WordModel {
  String? id;
  EngWordModel? engWord;
  String userDefinition;
  String? description;
  String? illustration;
  int level;
  int point;
  bool isPublic;
  bool isFavorite;

  String _engWordID = '';

  WordModel({
    this.id,
    required String engWordID,
    required this.userDefinition,
    this.description,
    this.illustration,
    this.level = 1,
    this.point = 0,
    this.isPublic = false,
    this.isFavorite = false,
  }) {
    _engWordID = engWordID;
  }

  Future<void> get loadEngWord async =>
      engWord = await EngWordRepo().getEngWord(_engWordID);

  factory WordModel.fromMap(Map<String, dynamic> map, String id) {
    return WordModel(
      id: id,
      engWordID: map['engWord'],
      userDefinition: map['userDefinition'],
      description: map['description'],
      illustration: map['illustration'],
      level: map['level'],
      point: map['point'],
      isFavorite: map['isFavorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'engWord': _engWordID,
      'userDefinition': userDefinition,
      'description': description,
      'illustration': illustration,
      'level': level,
      'point': point,
      'isPublic': isPublic,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'WordModel{id: $id, engWord: $engWord, userDefinition: $userDefinition, description: $description, illustration: $illustration, level: $level, point: $point, isPublic: $isPublic, isFavorite: $isFavorite}';
  }
}
