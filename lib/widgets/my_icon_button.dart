import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class MyIconButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final Function()? onTap;

  const MyIconButton({
    super.key,
    required this.icon,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: myColors.containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 28),
      ),
    );
  }
}
