import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';

class OptionButton extends StatelessWidget {
  final String label;
  final bool disabled;
  final Function() onPressed;
  const OptionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.heightRatio(context, 8),
      width: Dimensions.widthRatio(context, 75),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            disabled ? Colors.grey[500] : const Color(0xFF0077B6),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
        ),
        onPressed: disabled ? null : onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.fontSize16(context),
            color: disabled ? Colors.grey[350] : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
