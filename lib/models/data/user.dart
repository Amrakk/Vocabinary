import 'package:vocabinary/models/data/folder.dart';

class UserModel {
  String? id;
  String? email;
  String? password;
  String? name;
  String? avatar;
  List<FolderModel>? folders = [];

  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'],
      password: map['password'],
      name: map['name'],
      avatar: map['avatar'],
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
    return 'UserModel{id: $id, email: $email, password: $password, name: $name, avatar: $avatar, folders: $folders}';
  }
}
