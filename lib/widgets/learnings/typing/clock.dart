import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/viewmodels/learning/typing_view_model.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => ClockState();
}

class ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TypingViewModel>(
      builder: (_, typingViewModel, __) {
        return AnimatedContainer(
          width: Dimensions.widthRatio(context, 13),
          height: Dimensions.widthRatio(context, 13),
          duration: const Duration(milliseconds: 500),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: typingViewModel.seconds / TypingViewModel.max,
                color: typingViewModel.seconds > 5
                    ? AppColors.mainGreen
                    : AppColors.mainRed,
              ),
              Center(
                child: Text(
                  typingViewModel.seconds.toString(),
                  style: TextStyle(
                    color: typingViewModel.seconds > 5
                        ? AppColors.mainGreen
                        : AppColors.mainRed,
                    fontWeight: FontWeight.w800,
                    fontSize: Dimensions.widthRatio(context, 4.25),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
