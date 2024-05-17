import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';


class Button extends StatefulWidget {
   Button({ this.isLoading ,this.icon ,Function()? onPressed ,required this.nameButton,super.key}) : onPressed = onPressed ?? ((){});

   String nameButton;
    Function() onPressed;
    Icon? icon;
    bool? isLoading;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.isLoading ?? false ? null : widget.onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: widget.isLoading ?? false ? Colors.grey[800]  : const Color(0xFF023E8A) ,
          ),
          child: SizedBox(
            height: Dimensions.heightRatio(context, 6),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon != null ? widget.icon! : const SizedBox(),
                SizedBox(width: widget.icon != null ? 10 : 0),
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
