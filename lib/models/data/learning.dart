import 'package:cloud_firestore/cloud_firestore.dart';

class LearningModel {
  String? id;
  int score;
  String learningType;
  Timestamp? start;
  Timestamp? finish;

  LearningModel({
    this.id,
    this.score = 0,
    required this.learningType,
    this.start,
    this.finish,
  });

  factory LearningModel.fromMap(Map<String, dynamic> map, String id) {
    return LearningModel(
      id: id,
      score: map['score'] ?? 0,
      learningType: map['learningType'],
      start: map['start'],
      finish: map['finish'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'learningType': learningType,
      'start': start,
      'finish': finish,
    };
  }

  Duration get duration {
    if (start == null || finish == null) {
      return Duration.zero;
    }
    return finish!.toDate().difference(start!.toDate());
  }

  int compareTo(LearningModel other) {
    return score > other.score
        ? 1
        : score < other.score
            ? -1
            : duration.compareTo(other.duration);
  }

  @override
  String toString() {
    return 'LearningModel{id: $id, score: $score, learningType: $learningType, start: $start, finish: $finish}';
  }
}
