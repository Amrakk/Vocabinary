import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyDropDownButton extends StatefulWidget {
  const MyDropDownButton({Key? key}) : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton>{
  var style = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  var gradientColors = [
    const Color(0xff5efce8),
    const Color(0xff2196f3),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      underline: Container(),
      value: 'Week',
      items:  [
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
      onChanged: (value) {  },
    );
  }

}

