class LearningTypeModel {
  String? id;
  String? name;
  int weight;

  LearningTypeModel({
    this.id,
    this.name,
    this.weight = 0,
  });

  factory LearningTypeModel.fromMap(Map<String, dynamic> map) {
    return LearningTypeModel(
      id: map['id'],
      name: map['name'],
      weight: map['weight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
    };
  }
}
