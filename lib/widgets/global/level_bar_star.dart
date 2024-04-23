import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class LevelStarBar extends StatefulWidget {
  LevelStarBar({required this.level, super.key});

  int level;

  @override
  State<LevelStarBar> createState() {
    return LevelStarBarState();
  }
}

class LevelStarBarState extends State<LevelStarBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Icon(
          index + 1 <= widget.level ? Icons.star_rounded : Icons.star_border_rounded,
          color: const Color(0xFFEDC531),
          size: Dimensions.iconSize(context, 40),
        );
      }),
    );
  }
}
