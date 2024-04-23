import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class ConfirmButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final Function() onPressed;
  final IconData? icon;
  final double iconSize;
  final double heightRatio;
  final double widthRatio;
  final double borderRadius;

  const ConfirmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconSize = 20.0,
    this.fontSize = 16.0,
    this.heightRatio = 7.0,
    this.widthRatio = 55.5,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: Dimensions.heightRatio(context, heightRatio),
      width: Dimensions.widthRatio(context, widthRatio),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.08, 1.0],
          colors: AppColors.primaryButtonGradient,
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
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.fontSize(context, fontSize),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
          ],
        ),
      ),
    );
  }
}
