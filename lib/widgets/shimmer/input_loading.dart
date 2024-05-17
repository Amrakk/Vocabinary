import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vocabinary/utils/app_colors.dart';


class InputLoading extends StatelessWidget {
  const InputLoading({super.key});

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData appColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Shimmer.fromColors(
      baseColor: appColors.containerColor,
      highlightColor: Colors.grey[500]!,
      direction: ShimmerDirection.ltr,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColors.containerColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
      ),
    );
  }
}
