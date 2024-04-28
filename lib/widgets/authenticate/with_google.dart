import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';

import '../global/loading_indicator.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    showLoadingIndicator(context);
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
      closeLoadingIndicator(context);
      return user;
    } catch (error) {
      print(error);
      closeLoadingIndicator(context);
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          signInWithGoogle();
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: myColors.containerColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),),
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Brand(Brands.google, size: Dimensions.iconSize30(context),),
                SizedBox(width: Dimensions.widthRatio(context, 2)),
                Text("Login with Google", style: TextStyle(
                  fontSize: Dimensions.fontSize(context, 15),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
