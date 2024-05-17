import 'package:flutter/material.dart';

import 'package:vocabinary/utils/dimensions.dart';

class SliderLevel extends StatefulWidget {
   SliderLevel({required this.currentLevel ,super.key, required this.onLevelChanged});

  int currentLevel;
   final ValueChanged<int> onLevelChanged;

  @override
  State<SliderLevel> createState() => _SliderLevelState();
}

class _SliderLevelState extends State<SliderLevel> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Easy", style: TextStyle(fontSize: 20),),
        SizedBox(
          width: Dimensions.widthRatio(context, 60),
          child: Slider(
            value: widget.currentLevel.toDouble(),
            max: 3,
            min: 1,
            onChanged: (value) {
              setState(() {
                widget.onLevelChanged(value.toInt());
              });
            },),
        ),
        const Text("Hard", style: TextStyle(fontSize: 20),),
      ],
    );
  }
}
