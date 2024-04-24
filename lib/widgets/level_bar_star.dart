import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';

class LevelStarBar extends StatelessWidget {
  final int level;
  final double size;

  const LevelStarBar({required this.level, super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Icon(
          index + 1 <= level ? Icons.star_rounded : Icons.star_border_rounded,
          color: const Color(0xFFEDC531),
          size: Dimensions.iconSize(context, size),
        );
      }),
    );
  }
}
