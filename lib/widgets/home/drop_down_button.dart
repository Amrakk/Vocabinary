import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class MyDropDownButton extends StatefulWidget {
  const MyDropDownButton({super.key});

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  @override
  Widget build(BuildContext context) {
    const gradientColors = AppColors.lineChartGradient;
    final style = TextStyle(
      fontSize: Dimensions.fontSize(context, 15),
      fontWeight: FontWeight.bold,
    );

    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      underline: Container(),
      value: 'Week',
      items: [
        DropdownMenuItem(
          value: 'Week',
          child: GradientText(
            'Week',
            colors: gradientColors,
            style: style,
          ),
        ),
        DropdownMenuItem(
          value: 'Month',
          child: GradientText(
            'Month',
            colors: gradientColors,
            style: style,
          ),
        ),
        DropdownMenuItem(
          value: 'Year',
          child: GradientText(
            'Year',
            colors: gradientColors,
            style: style,
          ),
        ),
      ],
      onChanged: (value) {},
    );
  }
}
