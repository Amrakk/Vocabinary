import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/user_repo.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';

class SettingViewModel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepo();

  Future<bool> updateUser(String uid ,UserModel data) async {
    return await _userRepo.updateUser(uid, data);
  }
  Future<UserModel?> getUser(String uid) async {
    return await _userRepo.getUser(uid);
  }

}