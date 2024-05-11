import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';


class MyLoadingIndicator extends StatelessWidget {
  const MyLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: LoadingIndicator(
          indicatorType: Indicator.squareSpin,
          backgroundColor: Colors.transparent,
          colors: [
            Color(0xFF007FCB),
          ],
        ),
      ),
    );
  }
}

void showLoadingIndicator(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: MyLoadingIndicator(),
        );
      });
}

void closeLoadingIndicator(BuildContext context) {
  Navigator.of(context).pop();
}