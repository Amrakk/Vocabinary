import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class MyAnimatedContainer extends StatefulWidget {
  MyAnimatedContainer({required this.child, double? width, super.key})
      : width = width ?? 85;

  Widget child;
  double width;

  @override
  State<MyAnimatedContainer> createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<MyAnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: Dimensions.widthSize(context, widget.width),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x89000000),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
        child: widget.child,
      ),
    );
  }
}
