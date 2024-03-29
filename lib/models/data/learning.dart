import 'package:cloud_firestore/cloud_firestore.dart';

class LearningModel {
  String? id;
  double completion;
  String learningType;
  Timestamp? start;
  Timestamp? finish;

  LearningModel({
    this.id,
    this.completion = 0.0,
    required this.learningType,
    this.start,
    this.finish,
  });

  factory LearningModel.fromMap(Map<String, dynamic> map, String id) {
    return LearningModel(
      id: id,
      completion: map['completion'] ?? 0.0,
      learningType: map['learningType'],
      start: map['start'],
      finish: map['finish'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completion': completion,
      'learningType': learningType,
      'start': start,
      'finish': finish,
    };
  }

  @override
  String toString() {
    return 'LearningModel{id: $id, completion: $completion, learningType: $learningType, start: $start, finish: $finish}';
  }
}
