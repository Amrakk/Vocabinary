import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';


class Button extends StatefulWidget {
   Button({ Function()? onPressed ,required this.nameButton,super.key}) : onPressed = onPressed ?? ((){});

   String nameButton;
    Function() onPressed;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: InkWell(
        onTap: () {
          widget.onPressed();
        },
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFF023E8A),
          ),
          child: SizedBox(
            height: Dimensions.heightRatio(context, 7),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.nameButton,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                        fontSize: Dimensions.fontSize(context, 20))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
