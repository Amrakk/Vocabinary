import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';

class ConfirmButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final IconData? icon;
  const ConfirmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.heightRatio(context, 7),
      width: Dimensions.widthRatio(context, 55),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF023E8A)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.fontSize16(context),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
