import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

class InputDescriptionTopic extends StatefulWidget {
   const InputDescriptionTopic({ required this.textDescriptionController,super.key});

  final TextEditingController textDescriptionController;

  @override
  State<InputDescriptionTopic> createState() => _InputDescriptionTopicState();
}

class _InputDescriptionTopicState extends State<InputDescriptionTopic> {
  @override
  Widget build(BuildContext context) {
    final AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return  Container(
      height: Dimensions.heightRatio(context, 15),
      decoration: BoxDecoration(
        boxShadow:  const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
        color: myColors.containerColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: widget.textDescriptionController,
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
          fillColor: myColors.containerColor,
        ),
      ),
    );
  }
}
