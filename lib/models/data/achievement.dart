class AchievementModel {
  String? id;
  String? name;
  int weight;
  String? description;
  String? illustration;

  AchievementModel({
    this.id,
    this.name,
    this.weight = 0,
    this.description,
    this.illustration,
  });

  factory AchievementModel.fromMap(Map<String, dynamic> map, String id) {
    return AchievementModel(
      id: id,
      name: map['name'],
      weight: map['weight'],
      description: map['description'],
      illustration: map['illustration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
      'description': description,
      'illustration': illustration,
    };
  }

  @override
  String toString() {
    return 'AchievementModel{id: $id, name: $name, weight: $weight, description: $description, illustration: $illustration}';
  }
}
