import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class ConfirmButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final Function() onPressed;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double iconSize;
  final double heightRatio;
  final double widthRatio;
  final double borderRadius;
  final List<Color> colorsGradient;
  final List<double> stopsGradient;

  const ConfirmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.iconSize = 20.0,
    this.fontSize = 16.0,
    this.heightRatio = 7.0,
    this.widthRatio = 55.5,
    this.borderRadius = 10.0,
    this.stopsGradient = const [0.08, 1.0],
    this.colorsGradient = AppColors.primaryButtonGradient,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: Dimensions.heightRatio(context, heightRatio),
      width: Dimensions.widthRatio(context, widthRatio),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: stopsGradient,
          colors: colorsGradient,
        ),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null)
              Icon(
                leftIcon,
                color: Colors.white,
                size: iconSize,
              ),
            if (leftIcon != null)
              SizedBox(width: Dimensions.widthRatio(context, 0.75)),
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.fontSize(context, fontSize),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (rightIcon != null)
              SizedBox(width: Dimensions.widthRatio(context, 0.75)),
            if (rightIcon != null)
              Icon(
                rightIcon,
                color: Colors.white,
                size: iconSize,
              ),
          ],
        ),
      ),
    );
  }
}
