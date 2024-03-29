import 'package:cloud_firestore/cloud_firestore.dart';

class LearningModel {
  String? id;
  double point;
  String learningType;
  Timestamp? start;
  Timestamp? finish;

  LearningModel({
    this.id,
    this.point = 0,
    required this.learningType,
    this.start,
    this.finish,
  });

  factory LearningModel.fromMap(Map<String, dynamic> map, String id) {
    return LearningModel(
      id: id,
      point: map['point'] ?? 0,
      learningType: map['learningType'],
      start: map['start'],
      finish: map['finish'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'point': point,
      'learningType': learningType,
      'start': start,
      'finish': finish,
    };
  }

  @override
  String toString() {
    return 'LearningModel{id: $id, point: $point, learningType: $learningType, start: $start, finish: $finish}';
  }
}
