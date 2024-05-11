
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/viewmodels/authenticate/auth_view_model.dart';
import 'package:vocabinary/widgets/authenticate/input_text.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';
import '../../global/loading_indicator.dart';

class TypeEmail extends StatefulWidget {
  TypeEmail({ required this.emailCallback ,super.key});
  void Function(String) emailCallback;

  @override
  State<TypeEmail> createState() => _TypeEmailState();
}

class _TypeEmailState extends State<TypeEmail> {
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AuthenticateViewModel authViewModel = Provider.of<AuthenticateViewModel>(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Forgot Your Password?", style: TextStyle(fontSize: Dimensions.fontSize30(context), fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        const Text("Please enter your email address to verify your identity", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
        const SizedBox(height: 50),
        InputTextAuth(
          hintText: "E-mail address",
          icon: Icons.email,
          isPassword: false,
          controller: emailController,
        ),
        const SizedBox(height: 25), Button(
          nameButton: "Send Code",
          onPressed: () {
            if(EmailValidator.validate(emailController.text) == false) {
              ShowSnackBar.showError("Please enter a valid email address", context);
              return;
            }
            showLoadingIndicator(context);
            AuthenticationService.instance.isEmailRegistered(emailController.text).then((value) {
              if (value) {
                authViewModel.sendEmail(emailController.text).then((value) {
                  if(value){
                    closeLoadingIndicator(context);
                    widget.emailCallback(emailController.text);
                  } else {
                    closeLoadingIndicator(context);
                    ShowSnackBar.showError("Something went wrong!", context);
                  }
                });
              } else {
                closeLoadingIndicator(context);
                ShowSnackBar.showError("Email not found!", context);
              }
            });
          },
        )
      ],
    );
  }
}
