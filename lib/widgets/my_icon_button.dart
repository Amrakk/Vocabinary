import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimensions.height(context, size),
        width: Dimensions.width(context, size),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: Dimensions.iconSize(context, size / 1.6)),
      ),
    );
  }
}
