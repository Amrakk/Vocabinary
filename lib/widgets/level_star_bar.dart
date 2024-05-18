import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class LevelStarBar extends StatelessWidget {
  final int level;
  final double size;
  final Color? color;

  const LevelStarBar({required this.level, super.key, this.size = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Icon(
          index + 1 <= level ? Icons.star_rounded : Icons.star_border_rounded,
          color: color ?? levelToColor(level),
          size: Dimensions.iconSize(context, size),
        );
      }),
    );
  }

  Color levelToColor(int level) {
    if (level == 1) {
      return AppColors.mainGreen;
    } else if (level == 2) {
      return AppColors.mainBlue;
    } else if (level == 3) {
      return AppColors.mainYellow;
    } else {
      return AppColors.mainGreen;
    }
  }
}
