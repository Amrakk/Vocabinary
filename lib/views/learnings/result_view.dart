import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/learnings/confirm_button.dart';
import 'package:vocabinary/viewmodels/learning/quiz_view_model.dart';
import 'package:vocabinary/viewmodels/learning/typing_view_model.dart';
import 'package:vocabinary/widgets/learnings/background_container.dart';

class ResultView extends StatefulWidget {
  final QuizViewModel? quizViewModel;
  final TypingViewModel? typingViewModel;

  const ResultView({
    super.key,
    this.quizViewModel,
    this.typingViewModel,
  }) : assert(
          quizViewModel != null || typingViewModel != null,
          'Both view models must not be null.',
        );

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late String _duration;

  @override
  Widget build(BuildContext context) {
    print(1);
    return FutureBuilder(
      future: widget.quizViewModel != null
          ? widget.quizViewModel!.save()
          : widget.typingViewModel!.save(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            SizedBox(height: Dimensions.heightRatio(context, 13.25)),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/fireworks.png'),
                    Transform.flip(
                      flipX: true,
                      child: Image.asset('assets/images/fireworks.png'),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.heightRatio(context, 14)),
                      BackgroundContainer(
                        heightRatio: 15.5,
                        widthRatio: 80,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Dimensions.heightRatio(context, 2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildTotalScore(),
                                Container(
                                  height: Dimensions.heightRatio(context, 8),
                                  width: 1.75,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                _buildDuration(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.heightRatio(context, 5)),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(
                          Dimensions.widthRatio(context, 4.5),
                        ),
                        child: Icon(
                          Icons.emoji_events_rounded,
                          color: Colors.white,
                          size: Dimensions.widthRatio(context, 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.heightRatio(context, 2.75)),
            SizedBox(
              height: Dimensions.heightRatio(context, 36.5),
              width: Dimensions.widthRatio(context, 90),
              child: ListView.builder(
                cacheExtent: Dimensions.heightRatio(context, 50),
                padding: EdgeInsets.zero,
                // TODO: Remove comment after implementing typing view model
                itemCount: widget.quizViewModel != null
                    ? widget.quizViewModel!.count
                    : widget.typingViewModel!.count,
                itemBuilder: (context, index) => _buildAnswer(index),
              ),
            ),
            SizedBox(height: Dimensions.heightRatio(context, 2.75)),
            ConfirmButton(
              label: 'Finish',
              borderRadius: 50,
              stopsGradient: const [0.62, 0.87],
              colorsGradient: const [AppColors.correctColor, AppColors.primary],
              onPressed: () {
                widget.quizViewModel != null
                    ? widget.quizViewModel!.clear()
                    : widget.typingViewModel!.clear();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildTotalScore() => Column(
        children: [
          Icon(
            Icons.star_outline_rounded,
            size: Dimensions.widthRatio(context, 8),
            color: Colors.white,
          ),
          Text(
            'Points',
            style: TextStyle(
              color: const Color(0xFF9F9F9F),
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSize(context, 14),
            ),
          ),
          SizedBox(
            width: Dimensions.widthRatio(context, 20),
            height: Dimensions.heightRatio(context, 7),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    widget.quizViewModel != null
                        ? widget.quizViewModel!.score.toString()
                        : widget.typingViewModel!.score.toString(),
                    style: GoogleFonts.jomhuria(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: Dimensions.fontSize(context, 44),
                    ),
                  ),
                  Text(
                    ' /${widget.quizViewModel != null ? widget.quizViewModel!.totalScore.toString() : widget.typingViewModel!.totalScore.toString()}',
                    style: GoogleFonts.jomhuria(
                      color: const Color(0xFF9F9F9F),
                      fontWeight: FontWeight.w900,
                      fontSize: Dimensions.fontSize18(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _buildDuration() {
    final duration = widget.quizViewModel != null
        ? widget.quizViewModel!.duration
        : widget.typingViewModel!.duration;
    final minute = duration.inMinutes;
    final second = duration.inSeconds - (minute * 60);
    _duration = '${minute}m ${second.toString().padLeft(2, '0')}s';

    return Column(
      children: [
        Icon(
          Icons.access_alarms_rounded,
          size: Dimensions.widthRatio(context, 8),
          color: Colors.white,
        ),
        Text(
          'Time',
          style: TextStyle(
            color: const Color(0xFF9F9F9F),
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSize(context, 14),
          ),
        ),
        SizedBox(
          width: Dimensions.widthRatio(context, 20),
          height: Dimensions.heightRatio(context, 7),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _duration,
              style: GoogleFonts.jomhuria(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: Dimensions.fontSize(context, 44),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswer(int index) {
    final word = widget.quizViewModel != null
        ? widget.quizViewModel!.words[index]
        : widget.typingViewModel!.words[index];
    final isCorrect = widget.quizViewModel != null
        ? widget.quizViewModel!.isCorrect(index)
        : widget.typingViewModel!.isCorrect(index);

    Color color = isCorrect ? AppColors.correctColor : AppColors.wrongColor;

    return BackgroundContainer(
      heightRatio: 14,
      color: color,
      margin: EdgeInsets.only(
        bottom: Dimensions.heightRatio(context, 1.75),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.heightRatio(context, 1.5),
          horizontal: Dimensions.widthRatio(context, 4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (index + 1).toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: Dimensions.fontSize18(context),
                  ),
                ),
                BackgroundContainer(
                  heightRatio: 3.25,
                  widthRatio: 12,
                  borderRadius: 10,
                  color: (isCorrect
                          ? color.withBlue(255).withGreen(115)
                          : color.withRed(225))
                      .withOpacity(0.6),
                  child: Icon(
                    isCorrect
                        ? Icons.done_outline_rounded
                        : Icons.block_rounded,
                    color: Colors.white,
                    size: Dimensions.widthRatio(context, 4.75),
                  ),
                )
              ],
            ),
            Text(
              word.engWord?.word ?? '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: Dimensions.fontSize22(context),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  'Correct Answer:  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.fontSize12(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  word.userDefinition,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.fontSize(context, 14),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
