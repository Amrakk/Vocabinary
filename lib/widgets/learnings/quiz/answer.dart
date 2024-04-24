import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/learnings/quiz/answer_controller.dart';

class Answer extends StatefulWidget {
  final String answer;
  final bool isCorrect;
  final Function()? onTap;
  final AnswerController? controller;

  const Answer({
    super.key,
    required this.answer,
    required this.isCorrect,
    this.onTap,
    this.controller,
  });

  @override
  State<Answer> createState() => AnswerState();
}

class AnswerState extends State<Answer> {
  bool _isSelected = false;
  bool _isDisabled = false;

  get isCorrect => widget.isCorrect;

  void disable() {
    setState(() {
      _isDisabled = true;
    });
  }

  void select() {
    setState(() {
      _isSelected = true;
    });
  }

  @override
  void initState() {
    widget.controller?.state = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isDisabled
          ? null
          : () {
              if (widget.onTap != null) widget.onTap!();
              select();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 125),
        width: Dimensions.widthRatio(context, 65),
        margin: EdgeInsets.only(
          bottom: Dimensions.heightRatio(context, 2),
        ),
        height: Dimensions.heightRatio(context, 6.5),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.widthRatio(context, 4),
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? widget.isCorrect
                  ? AppColors.correctColor
                  : AppColors.wrongColor
              : Colors.transparent,
          border: Border.all(color: const Color(0xFF878787), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              _isSelected
                  ? widget.isCorrect
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded
                  : Icons.circle_rounded,
              size: Dimensions.iconSize(context, 34),
              color: Colors.white30,
            ),
            SizedBox(width: Dimensions.widthRatio(context, 4)),
            Text(
              widget.answer,
              style: TextStyle(
                fontSize: Dimensions.fontSize16(context),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
