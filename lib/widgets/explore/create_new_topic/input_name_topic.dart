import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';

class InputTopicName extends StatefulWidget {
  const InputTopicName({super.key});

  // var _textNameController = TextEditingController();

  @override
  State<InputTopicName> createState() => _InputTopicNameState();
}

class _InputTopicNameState extends State<InputTopicName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.heightRatio(context, 30),
      width: Dimensions.widthRatio(context, 60),
      decoration:  BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(25),
      ),
      child:  TextField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.center,
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: Dimensions.fontSize(context, 40),
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent,),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: const Color(0xFFE5E5E5),
        ),
      ),
    );
  }
}
