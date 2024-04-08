import '../utils/dimensions.dart';
import 'package:flutter/material.dart';

class MyAnimatedContainer extends StatefulWidget {
  final Widget child;
  final double width;

  const MyAnimatedContainer({required this.child, this.width = 85, super.key});

  @override
  State<MyAnimatedContainer> createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<MyAnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: Dimensions.widthRatio(context, widget.width),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x89000000),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height20(context),
          horizontal: Dimensions.width(context, 15),
        ),
        child: widget.child,
      ),
    );
  }
}
