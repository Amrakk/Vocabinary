import 'package:vocabinary/data/repositories/achievement_repo.dart';
import 'package:vocabinary/models/data/achievement.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/data/repositories/folder_repo.dart';

class UserModel {
  String? id;
  String? email;
  String? password;
  String? name;
  String? avatar;
  List<String> achievementIDs;

  List<FolderModel>? folders;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.avatar,
    this.achievementIDs = const [],
    this.folders = const [],
  });

  Future<void> get loadFolders async {
    assert(id != null, 'User ID is null');
    folders = await FolderRepo().getFolders(id!);
  }

  Future<List<AchievementModel>> get getAchievements async {
    assert(id != null, 'User ID is null');

    if (achievementIDs.isEmpty) return [];
    var achievements = <AchievementModel>[];

    for (var achievementID in achievementIDs) {
      var achievement = await AchievementRepo().getAchievement(achievementID);
      if (achievement != null) achievements.add(achievement);
    }

    return achievements;
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'],
      password: map['password'],
      name: map['name'],
      avatar: map['avatar'],
      achievementIDs: List<String>.from(map['achievements'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email ?? '',
      'password': password ?? '',
      'name': name ?? '',
      'avatar': avatar ?? '',
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, email: $email, password: $password, name: $name, avatar: $avatar, achievements: $achievementIDs}';
  }
}
