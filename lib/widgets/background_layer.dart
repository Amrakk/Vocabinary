import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class BackgroundLayer extends StatelessWidget {
  final double ratio;

  const BackgroundLayer({super.key, this.ratio = 10});
  // TODO: add animation to the container

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      height: Dimensions.heightRatio(context, ratio),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: AppColors.animatedLayerGradient,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x89000000),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
