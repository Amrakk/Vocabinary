import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocabinary/data/repositories/user_repo.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/app_colors.dart';

import 'package:vocabinary/widgets/authenticate/with_google.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';

import '../../models/data/user.dart';
import '../../utils/dimensions.dart';
import '../../widgets/authenticate/input_text.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String password = '';
  String confirmPassword = '';
  String email = '';
  String name = '';

  final formKey = GlobalKey<FormState>();
  // Auth worker
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;
  final UserRepo userRepo = UserRepo();

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      showLoadingIndicator(context);
      formKey.currentState!.save();
      UserModel user = UserModel(
        email: email,
        name: name,
      );
      var credential =
          await _authenticationService.signUp(email: email, password: password);
      if (credential is String) {
        closeLoadingIndicator(context);
        AnimatedSnackBar.material(
          credential,
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          duration: const Duration(seconds: 5),
        ).show(context);
      } else {
        userRepo.createUser(user, credential.user!.uid);
        closeLoadingIndicator(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AppBar(
                backgroundColor: const Color(0xFF0096C7),
              ),
              IgnorePointer(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.29,
                  child: SvgPicture.asset(
                    'images/wave.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                bottom: 0,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height ,
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.padding(context, 40)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome!",
                              style: TextStyle(
                                fontSize: Dimensions.fontSize(context, 40),
                                fontWeight: FontWeight.bold,
                              )),
                          Text("Sign up to explore the app",
                              style: TextStyle(
                                fontSize: Dimensions.fontSize(context, 20),
                                color: myColors.subTextColor,
                              )),
                          SizedBox(height: Dimensions.heightRatio(context, 5)),
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  InputTextAuth(
                                    hintText: "Name",
                                    icon: Icons.person,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => name = value!,
                                  ),
                                  SizedBox(
                                      height:
                                          Dimensions.heightRatio(context, 2.5)),
                                  InputTextAuth(
                                    hintText: "Email",
                                    icon: Icons.email,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (EmailValidator.validate(value) == false) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => email = value!,
                                  ),
                                  SizedBox(
                                      height:
                                          Dimensions.heightRatio(context, 2.5)),
                                  InputTextAuth(
                                    hintText: "Password",
                                    icon: Icons.lock,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      } else if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      password = value;
                                      return null;
                                    },
                                    onSaved: (value) => password = value!,
                                  ),
                                  SizedBox(
                                      height:
                                          Dimensions.heightRatio(context, 2.5)),
                                  InputTextAuth(
                                    hintText: "Confirm Password",
                                    icon: Icons.lock,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password again';
                                      } else if (value != password) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => password = value!,
                                  ),
                                ],
                              )),
                          SizedBox(
                              height: Dimensions.heightRatio(context, 0.7)),
                          SizedBox(
                              height: Dimensions.heightRatio(context, 3.5)),
                          Button(
                            nameButton: "Sign Up",
                            onPressed: onSubmit,
                          ),
                          SizedBox(
                              height: Dimensions.heightRatio(context, 3.5)),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text("or",
                                      style: TextStyle(
                                        fontSize:
                                            Dimensions.fontSize(context, 16),
                                        color: myColors.subTextColor,
                                      )),
                                ),
                                const Expanded(
                                  child: Divider(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.heightRatio(context, 2)),
                          const LoginWithGoogle(),
                          SizedBox(
                              height: Dimensions.heightRatio(context, 2.5)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
