import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';

class InputDescriptionTopic extends StatefulWidget {
  const InputDescriptionTopic({super.key});

  @override
  State<InputDescriptionTopic> createState() => _InputDescriptionTopicState();
}

class _InputDescriptionTopicState extends State<InputDescriptionTopic> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Dimensions.heightRatio(context, 15),
      decoration: BoxDecoration(
        boxShadow:  const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
        color: const Color(0xFF616161),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        maxLines: null,
        cursorColor: Colors.white,
        style: TextStyle(
          fontSize: Dimensions.fontSize(context, 20),
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hoverColor: Colors.transparent,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent,),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: const Color(0xFF616161),
        ),
      ),
    );
  }
}
