import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';

class ProgressBar extends StatelessWidget {
  final int duration;
  final Color color;
  final Color backgroundColor;
  final double value;
  final double height, radius, padding;

  const ProgressBar({
    super.key,
    this.duration = 300,
    this.color = Colors.blue,
    this.backgroundColor = Colors.black26,
    required this.value,
    this.height = 8,
    this.radius = 50,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: duration),
              width: Dimensions.width(context, width),
              height: Dimensions.height(context, height + (padding * 2)),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: padding),
              duration: Duration(milliseconds: duration),
              width: Dimensions.width(context, value * width),
              height: Dimensions.height(context, height),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ],
        );
      },
    );
  }
}
