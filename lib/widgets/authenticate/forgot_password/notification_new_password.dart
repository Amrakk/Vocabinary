import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';
import '../../global/button.dart';

class NewPasswordNotification extends StatefulWidget {
   NewPasswordNotification({required this.email ,super.key});

  String email;

  @override
  State<NewPasswordNotification> createState() => _NewPasswordNotificationState();
}

class _NewPasswordNotificationState extends State<NewPasswordNotification> {
  bool _isResendDisabled = false;
  int _resendTimeout = 10;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 300,
            height: 300,
            child: Image.asset('images/email_sent.png', fit: BoxFit.fill)),
        Text("Password Reset Email Sent",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Dimensions.fontSize(context, 25),
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 7),
        const Text(
          "We've Sent You A Secure Link to Safely To Change Your Password and Keep Your Account Protected.",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Button(
          nameButton: 'Done',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: _isResendDisabled ?  null : () {
            showLoadingIndicator(context);
            AuthenticationService.instance.sendEmailResetPassword(widget.email).then((value) {
              if(value){
                closeLoadingIndicator(context);
                ShowSnackBar.showSuccess( "Email Sent Successfully", context,);
              }
              else{
                closeLoadingIndicator(context);
                ShowSnackBar.showError("Email Can Not Sent", context);
              }
            });
            setState(() {
              _isResendDisabled = true;
            });
            Timer.periodic(const Duration(seconds: 1), (timer) {
              if(_resendTimeout >0){
                _resendTimeout--;
              }
              else{
                timer.cancel();
                setState(() {
                  _isResendDisabled = false;
                  _resendTimeout = 10;
                });
              }
            });
          },
          child:  SizedBox(
            height: 40,
            width: 120,
            child: Center(
              child: Text(
                "Resend Email",
                style: TextStyle(
                  color: _isResendDisabled ?  Colors.grey : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
