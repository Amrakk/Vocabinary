import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/learnings/background_container_controller.dart';

class BackgroundContainer extends StatefulWidget {
  final Color color;
  final double widthRatio;
  final double heightRatio;
  final double borderRadius;
  final int duration;
  final Widget child;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;
  final BackgroundContainerController? controller;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.margin,
    this.duration = 300,
    this.widthRatio = 85,
    this.heightRatio = 10,
    this.borderRadius = 16.0,
    this.color = AppColors.primary,
    this.borderColor = Colors.transparent,
    this.controller,
  });

  @override
  State<BackgroundContainer> createState() => BackgroundContainerState();
}

class BackgroundContainerState extends State<BackgroundContainer> {
  double _widthRatio = 0;
  double _heightRatio = 0;

  @override
  void initState() {
    _widthRatio = widget.widthRatio;
    _heightRatio = widget.heightRatio;
    super.initState();
    widget.controller?.state = this;
  }

  void updateSize({double? widthRatio, double? heightRatio}) {
    setState(() {
      _widthRatio = widthRatio ?? _widthRatio;
      _heightRatio = heightRatio ?? _heightRatio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.duration),
      height: Dimensions.heightRatio(context, _heightRatio),
      width: Dimensions.widthRatio(context, _widthRatio),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderColor == Colors.transparent ? 0 : 2.25,
        ),
      ),
      child: widget.child,
    );
  }
}
