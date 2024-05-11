import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/authenticate/forgot_password/type_email.dart';
import 'package:vocabinary/widgets/authenticate/forgot_password/notification_new_password.dart';
import 'package:vocabinary/widgets/authenticate/forgot_password/verify_code.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  // Variables for between pages
  String email = '';
 // Callback Function
  void emailCallback(String email) {
    setState(() {
      this.email = email;
      _currentPage = 1;
      _navigatePage(_currentPage);
    });
  }

  void otpCallback() {
    setState(() {
      _currentPage = 2;
      _navigatePage(_currentPage);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigatePage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: Dimensions.widthRatio(context, 25),
                    height: 10,
                    decoration: BoxDecoration(
                      color: _currentPage >= index
                          ? const Color(0xFF0077B6)
                          : const Color(0xFF797979),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                })),
          )),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TypeEmail(emailCallback: emailCallback),
            VerifyCode(otpCallback: otpCallback ,email: email),
             NewPasswordNotification(email: email,),
          ],
        ),
      ),
    );
  }

  Widget buildPage(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
