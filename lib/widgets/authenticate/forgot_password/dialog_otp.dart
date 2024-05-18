import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/viewmodels/authenticate/auth_view_model.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';

class ShowDialogTypingOtp {
  ShowDialogTypingOtp();
  Future<bool> showDialog(BuildContext context, String email) async {
    bool isWrongOtp = false;
    bool isResendDisabled = false;
    int resendTimeout = 60;
    AppColorsThemeData myColors =
    Theme.of(context).extension<AppColorsThemeData>()!;
    final authViewModel =
    Provider.of<AuthenticateViewModel>(context, listen: false);
     final result = await showAnimatedDialog<bool>(
       animationType: DialogTransitionType.scale,
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            const SizedBox(
                              width: double.infinity ,
                            ),
                            const Text(
                              'Verify your email',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Positioned(
                              right: -15,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "We've sent a 6-digit code to $email",
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    )),
                children: [
                  OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.center,
                    numberOfFields: 6,
                    focusedBorderColor: myColors.blueColor,
                    filled: true,
                    fieldHeight: 40,
                    fieldWidth: 35,
                    fillColor: Colors.white10,
                    showFieldAsBox: true,
                    enabledBorderColor: isWrongOtp ? Colors.red : Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8),
                    textStyle: const TextStyle(fontSize: 20),
                    onSubmit: (String pin) {
                      if (authViewModel.verifyOtp(pin)) {
                        resendTimeout = 0;
                        Navigator.of(context).pop(true);
                      } else {
                        setState(() {
                          isWrongOtp = true;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                            authViewModel.sendEmail(email);
                            ShowSnackBar.showSuccess("Code sent to $email", context);
                            Timer.periodic(const Duration(seconds: 1), (timer) {
                              if(resendTimeout > 0){
                                setState(() {
                                  resendTimeout --;
                                  isResendDisabled = true;
                                });
                              } else if(resendTimeout == 0){
                                timer.cancel();
                                setState(() {
                                  isResendDisabled = false;
                                  resendTimeout = 60;
                                });
                              }
                              else {
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
            },
          );
        },
    );
    return result ?? false;
  }
}
