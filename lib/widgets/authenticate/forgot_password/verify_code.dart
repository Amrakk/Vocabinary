import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/utils/app_colors.dart';

import 'package:vocabinary/viewmodels/authenticate/auth_view_model.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';

import '../../global/show_snack_bar.dart';

class VerifyCode extends StatefulWidget {
   VerifyCode({required this.otpCallback ,required this.email ,super.key});

  String email;
  void Function() otpCallback;

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool isWrongOtp = false;
  bool isResendDisabled = false;
  int resendTimeout = 60;
  @override
  Widget build(BuildContext context) {
    final authViewModel =
    Provider.of<AuthenticateViewModel>(context, listen: false);
    AppColorsThemeData myColors =
    Theme.of(context).extension<AppColorsThemeData>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verification Code Entry", style: TextStyle(fontSize: Dimensions.fontSize30(context), fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
         Text("Please enter the code sent to ${widget.email}", style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),
        OtpTextField(
          mainAxisAlignment: MainAxisAlignment.center,
          numberOfFields: 6,
          focusedBorderColor: myColors.blueColor,
          filled: true,
          keyboardType: TextInputType.number,
          fieldHeight: Dimensions.heightRatio(context, 8),
          fieldWidth: Dimensions.widthRatio(context, 12),
          fillColor: Colors.white10,
          showFieldAsBox: true,
          enabledBorderColor: isWrongOtp ? Colors.red : Colors.transparent,
          contentPadding:  const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          textStyle: const TextStyle(fontSize: 20),
          onSubmit: (String pin) {
            if (authViewModel.verifyOtp(pin)) {
              showLoadingIndicator(context);
              AuthenticationService.instance.sendEmailResetPassword(widget.email).then((value) {
                if(value){
                  closeLoadingIndicator(context);
                  widget.otpCallback();
                } else {
                  closeLoadingIndicator(context);
                  ShowSnackBar.showError("Something went wrong!", context);
                }
              });
            } else {
              setState(() {
                isWrongOtp = true;
              });
            }
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't receive the code?",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: () async {
                if(!isResendDisabled){
                  setState(() {
                    isResendDisabled = true;
                  });
                  ShowSnackBar.showInfo("Sending", context);
                  authViewModel.sendEmail(widget.email);
                  ShowSnackBar.showSuccess("Code sent to ${widget.email}", context);
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    if(resendTimeout > 0){
                      setState(() {
                        resendTimeout --;
                        isResendDisabled = true;
                      });
                    } else {
                      timer.cancel();
                      setState(() {
                        isResendDisabled = false;
                        resendTimeout = 60;
                      });
                    }
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Text( isResendDisabled ? "Please wait ${resendTimeout}s to resend" : "Resend",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isResendDisabled ? Colors.grey : myColors.blueColor,),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
