import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';


class Button extends StatefulWidget {
   Button({ required this.nameButton,super.key});

  String nameButton;
  // final Function() onPressed;
  //  Icon icon;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        // Todo: Play button
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
                      color: Colors.white,
                      fontSize: Dimensions.fontSize(context, 22))),
            ],
          ),
        ),
      ),
    );
  }
}
