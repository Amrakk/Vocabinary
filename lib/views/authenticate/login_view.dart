import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/authenticate/input_text.dart';
import 'package:vocabinary/widgets/authenticate/with_google.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import '../../services/firebase/authentication_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;
  bool isLogging = false;

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoadingIndicator(context);
      var mess =
          await _authenticationService.signIn(email: email, password: password);
      if (mess != null) {
        closeLoadingIndicator(context);
        AnimatedSnackBar.material(
          mess,
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          duration: const Duration(seconds: 5),
        ).show(context);
      } else {
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
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SvgPicture.asset(
                    'assets/images/wave.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
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
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.padding(context, 40)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi there!",
                              style: TextStyle(
                                fontSize: Dimensions.fontSize(context, 40),
                                fontWeight: FontWeight.bold,
                              )),
                          Text("Please, login to continue",
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
                                    hintText: "Email",
                                    icon: Icons.email,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (EmailValidator.validate(
                                              value) ==
                                          false) {
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
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => password = value!,
                                  ),
                                ],
                              )),
                          SizedBox(
                              height: Dimensions.heightRatio(context, 0.7)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text("Forgot password?",
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSize(context, 16),
                                    color: myColors.subTextColor,
                                  )),
                            ),
                          ),
                          SizedBox(
                              height: Dimensions.heightRatio(context, 3.5)),
                          Button(
                            nameButton: "Login",
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
                          GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don’t have an account yet?",
                                      style: TextStyle(
                                        fontSize:
                                            Dimensions.fontSize(context, 16),
                                      )),
                                  SizedBox(
                                      width: Dimensions.widthRatio(context, 1)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        '/register',
                                        arguments: null,
                                      );
                                    },
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSize(context, 16),
                                          color: myColors.blueColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
