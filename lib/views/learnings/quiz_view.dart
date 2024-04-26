import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/widgets/progress_bar.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/views/learnings/result_view.dart';
import 'package:vocabinary/widgets/learnings/confirm_button.dart';
import 'package:vocabinary/viewmodels/learning/quiz_view_model.dart';

class QuizView extends StatefulWidget {
  final String topicID;
  final List<WordModel> words;

  const QuizView({super.key, required this.topicID, required this.words});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool _isDone = false;
  late QuizViewModel _quizViewModel;

  void init() async {
    widget.words.shuffle();
    _quizViewModel = Provider.of<QuizViewModel>(context, listen: false);
    _quizViewModel.init(widget.words, topicID: widget.topicID);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: handle disable/dialog for back button
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(
            left: Dimensions.widthRatio(context, 5),
            top: Dimensions.heightRatio(context, 2),
          ),
          height: Dimensions.heightRatio(context, 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz Mode',
                style: TextStyle(
                  fontSize: Dimensions.fontSize18(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: Dimensions.height(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<QuizViewModel>(
                    builder: (_, quizViewModel, __) => Text(
                      quizViewModel.progress < 1
                          ? '${quizViewModel.count} words'
                          : 'Done',
                      style: TextStyle(
                        fontSize: Dimensions.fontSize(context, 15),
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width(context, 14)),
                  Consumer<QuizViewModel>(
                    builder: (_, quizViewModel, __) {
                      return SizedBox(
                        width: Dimensions.widthRatio(context, 40),
                        child: ProgressBar(
                          height: Dimensions.height(context, 10),
                          duration: 300,
                          value: quizViewModel.progress,
                          color: const Color(0xFFCCFF33),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          const BackgroundLayer(ratio: 12),
          _isDone
              ? ResultView(quizViewModel: _quizViewModel)
              : _buildQuizScreen(),
        ],
      ),
    );
  }

  Widget _buildQuizScreen() => Column(
        children: [
          SizedBox(height: Dimensions.heightRatio(context, 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: Dimensions.heightRatio(context, 20),
                width: Dimensions.widthRatio(context, 70),
                child: Image.asset(
                  'assets/images/studying.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: Dimensions.heightRatio(context, 2)),
            ],
          ),
          SizedBox(height: Dimensions.heightRatio(context, 1)),

          // Quiz Cards
          AnimatedContainer(
            width: Dimensions.widthRatio(context, 85),
            height: Dimensions.heightRatio(context, 60),
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.widthRatio(context, 8),
            ),
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: const Color(0xFF494949),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Dimensions.widthRatio(context, 85),
                  height: Dimensions.heightRatio(context, 47),
                  child: PageView.builder(
                    controller: _quizViewModel.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _quizViewModel.quizzes[index];
                    },
                    itemCount: _quizViewModel.count,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.widthRatio(context, 8),
                      ),
                      child: Consumer<QuizViewModel>(
                        builder: (_, quizViewModel, __) => ConfirmButton(
                          label: quizViewModel.count - 1 >
                                  quizViewModel.currentIndex
                              ? 'Next'
                              : 'Finish',
                          onPressed: () async {
                            if (quizViewModel.count - 1 <
                                quizViewModel.currentIndex) return;

                            quizViewModel.count - 1 > quizViewModel.currentIndex
                                ? quizViewModel.next()
                                : setState(() {
                                    _quizViewModel.done();
                                    _isDone = true;
                                  });
                          },
                          heightRatio: 5,
                          widthRatio: 25,
                          fontSize: Dimensions.fontSize(context, 14),
                          stopsGradient: const [0.6, 1.2],
                          colorsGradient: const [
                            AppColors.correctColor,
                            Color(0xFF023E8A)
                          ],
                          rightIcon: quizViewModel.count - 1 >
                                  quizViewModel.currentIndex
                              ? Icons.arrow_forward_ios_rounded
                              : null,
                          iconSize: Dimensions.iconSize(context, 15),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ), // Quiz Card
        ],
      );
}
