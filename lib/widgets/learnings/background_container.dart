import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class BackgroundContainer extends StatelessWidget {
  final Color color;
  final double widthRatio;
  final double heightRatio;
  final double borderRadius;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  const BackgroundContainer({
    super.key,
    required this.child,
    this.margin,
    this.widthRatio = 85,
    this.heightRatio = 10,
    this.borderRadius = 16.0,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: Dimensions.heightRatio(context, heightRatio),
      width: Dimensions.widthRatio(context, widthRatio),
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
