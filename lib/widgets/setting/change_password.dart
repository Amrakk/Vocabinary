import 'package:flutter/material.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';

import '../authenticate/input_text.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Change Password',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 25, right: 25),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputTextAuth(
                        icon: Icons.lock,
                        hintText: 'Old Password',
                        isPassword: true,
                        controller: oldPasswordController,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextAuth(
                        icon: Icons.lock,
                        hintText: 'New Password',
                        isPassword: true,
                        controller: newPasswordController,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextAuth(
                        icon: Icons.lock,
                        hintText: 'Confirm Password',
                        isPassword: true,
                        validator: (value) {
                          if (value != newPasswordController.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),
              Button(
                nameButton: 'Change Password',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showLoadingIndicator(context);
                    bool result = await AuthenticationService.instance
                        .checkCurrentPassword(oldPasswordController.text);
                    if (result) {
                      bool changeResult = await AuthenticationService.instance
                          .changePassword(newPasswordController.text);
                      if (changeResult) {
                        ShowSnackBar.showSuccess("Change Password Successfully", context);
                      } else {
                        ShowSnackBar.showError("Password Is Too Weak", context);
                      }
                    } else {
                      ShowSnackBar.showError("Old Password Is Not Correct", context);
                    }
                    oldPasswordController.clear();
                    newPasswordController.clear();
                    closeLoadingIndicator(context);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
