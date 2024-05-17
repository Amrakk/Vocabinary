import 'package:flutter/material.dart';
import 'package:vocabinary/data/repositories/user_repo.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';

class SettingViewModel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepo();
  final uidCurrentUser = AuthenticationService.instance.currentUser!.uid;

  Future<bool> updateUser(UserModel data) async {
    return await _userRepo.updateUser(uidCurrentUser, data);
  }
  Future<UserModel?> getUser() async {
    return await _userRepo.getUser(uidCurrentUser);
  }

}