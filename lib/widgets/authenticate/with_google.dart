import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vocabinary/data/repositories/user_repo.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';
import '../global/loading_indicator.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserRepo _userRepo = UserRepo();

 Future<dynamic> signInWithGoogle() async {
  showLoadingIndicator(context);
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(googleSignInAccount.email);
    closeLoadingIndicator(context);

    if (signInMethods.isNotEmpty) {
      // Login
      for (var i in signInMethods) {
        if(i == 'google.com'){
          await FirebaseAuth.instance.signInWithCredential(credential);
        }
        else {
          ShowSnackBar.showError("Another user has use this email as their account", context);
        }
      }
    } else {
      // Register
      final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      if(authResult.additionalUserInfo!.isNewUser){
        await _userRepo.createUser(
            UserModel(email: authResult.user!.email,  name: authResult.user!.displayName,), authResult.user!.uid );
      }
    }
  } catch (e) {
    closeLoadingIndicator(context);
    ShowSnackBar.showError(e.toString(), context);
  }
}

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          var result = await signInWithGoogle();
          if(result is String){
            AnimatedSnackBar.material(
              result,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 5),
            ).show(context);
          }
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
