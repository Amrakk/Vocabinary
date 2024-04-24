import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/level_bar_star.dart';
import 'package:vocabinary/widgets/learnings/quiz/answer.dart';
import 'package:vocabinary/widgets/learnings/quiz/answer_controller.dart';

class Quiz extends StatefulWidget {
  final int level;
  final String question;
  final String answer;
  final Function() onRight;
  final List<String> options;

  const Quiz({
    super.key,
    required this.level,
    required this.question,
    required this.answer,
    required this.options,
    required this.onRight,
  }) : assert(options.length == 3, 'Options must be 3');

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<AnswerController> _answerControllers = List.generate(
    4,
    (index) => AnswerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthRatio(context, 8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select an answer:',
                style: TextStyle(
                  color: const Color(0xFFD7D7D7),
                  fontSize: Dimensions.fontSize(context, 13),
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Level of difficulty
              LevelStarBar(
                level: widget.level,
                size: Dimensions.iconSize30(context),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                widget.question,
                style: TextStyle(
                  fontSize: Dimensions.fontSize30(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // Answer options
          Column(
            children: _buildAnswers(),
          ),
        ],
      ),
    );
  }

  void _onAnswerSelected() {
    for (var controller in _answerControllers) {
      if (controller.isCorrect) controller.select();
      controller.disable();
    }
  }

  List<Answer> _buildAnswers() {
    var list = List.generate(
      3,
      (index) => Answer(
        answer: widget.options[index],
        isCorrect: false,
        controller: _answerControllers[index],
        onTap: _onAnswerSelected,
      ),
    );

    list.add(
      Answer(
        answer: widget.answer,
        isCorrect: true,
        controller: _answerControllers[3],
        onTap: () {
          widget.onRight();
          _onAnswerSelected();
        },
      ),
    );

    list.shuffle();
    return list;
  }
}
