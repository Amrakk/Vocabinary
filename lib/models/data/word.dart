import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/data/repositories/eng_word_repo.dart';

class WordModel {
  String? id;
  EngWordModel? engWord;
  String userDefinition;
  String? description;
  String? illustration;
  int point;
  bool isPublic;
  bool isFavorite;

  String _engWordRef = '';

  WordModel({
    this.id,
    required String engWordRef,
    required this.userDefinition,
    this.description,
    this.illustration,
    this.point = 0,
    this.isPublic = false,
    this.isFavorite = false,
  }) {
    _engWordRef = engWordRef;
  }

  Future<void> get loadEngWord async =>
      engWord = await EngWordRepo().getEngWord(path: _engWordRef);

  factory WordModel.fromMap(Map<String, dynamic> map, String id) {
    return WordModel(
      id: id,
      engWordRef: map['engWord'],
      userDefinition: map['userDefinition'],
      description: map['description'],
      illustration: map['illustration'],
      point: map['point'],
      isFavorite: map['isFavorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'engWord': _engWordRef,
      'userDefinition': userDefinition,
      'description': description,
      'illustration': illustration,
      'point': point,
      'isPublic': isPublic,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'WordModel{id: $id, engWord: $engWord, userDefinition: $userDefinition, description: $description, illustration: $illustration, point: $point, isPublic: $isPublic, isFavorite: $isFavorite}';
  }
}
