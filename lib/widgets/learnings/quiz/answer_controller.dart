import 'package:vocabinary/widgets/learnings/quiz/answer.dart';

class AnswerController {
  AnswerState? state;

  void select() => state!.select();
  void disable() => state!.disable();
  bool get isCorrect => state!.isCorrect;
}
