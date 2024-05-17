import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/learnings/background_container_controller.dart';
import 'package:vocabinary/widgets/learnings/typing/clock.dart';
import 'package:vocabinary/widgets/progress_bar.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/views/learnings/result_view.dart';
import 'package:vocabinary/viewmodels/learning/typing_view_model.dart';
import 'package:vocabinary/widgets/learnings/background_container.dart';

class TypingView extends StatefulWidget {
  final String topicID;
  final List<WordModel> words;

  const TypingView({super.key, required this.topicID, required this.words});

  @override
  State<TypingView> createState() => TypingViewState();
}

class TypingViewState extends State<TypingView> {
  final _focusNode = FocusNode();
  final _mainContainerController = BackgroundContainerController();

  late TypingViewModel _typingViewModel;
  late TextEditingController _textController;
  late FlipCardController _flipCardController;

  bool _isDone = false;

  void onDone() {
    setState(() {
      _isDone = true;
    });
  }

  void init() async {
    widget.words.shuffle();
    _typingViewModel = Provider.of<TypingViewModel>(context, listen: false);
    _typingViewModel.init(widget.words, topicID: widget.topicID);
    _flipCardController = _typingViewModel.flipCardController;
    _textController = _typingViewModel.textController;
  }

  @override
  void initState() {
    init();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _mainContainerController.updateSize(heightRatio: 40);
      } else {
        _mainContainerController.updateSize(heightRatio: 55);
      }
    });
    super.initState();
    _typingViewModel.startTimer();
    _typingViewModel.setViewState(this);
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    _focusNode.requestFocus();
    if (_typingViewModel.isRunning) return;

    await _typingViewModel.next(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                  'Typing Mode',
                  style: TextStyle(
                    fontSize: Dimensions.fontSize18(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Dimensions.height(context, 2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<TypingViewModel>(
                      builder: (_, typingViewModel, __) => Text(
                        typingViewModel.progress < 1
                            ? '${typingViewModel.count} words'
                            : 'Done',
                        style: TextStyle(
                          fontSize: Dimensions.fontSize(context, 15),
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width(context, 14)),
                    Consumer<TypingViewModel>(
                      builder: (_, typingViewModel, __) {
                        return SizedBox(
                          width: Dimensions.widthRatio(context, 40),
                          child: ProgressBar(
                            height: Dimensions.height(context, 10),
                            duration: 300,
                            value: typingViewModel.progress,
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
            const BackgroundLayer(ratio: 28),
            _isDone
                ? ResultView(typingViewModel: _typingViewModel)
                : _buildTypingScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingScreen() => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.heightRatio(context, 12),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.heightRatio(context, 3.25),
                      right: Dimensions.widthRatio(context, 6),
                    ),
                    child: const Clock(),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                BackgroundContainer(
                  controller: _mainContainerController,
                  duration: 175,
                  widthRatio: 100,
                  heightRatio: 40,
                  borderRadius: 65,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BackgroundContainer(
                        heightRatio: 14,
                        widthRatio: 100,
                        borderRadius: 40,
                        color: Colors.white,
                        child: Container(
                          width: Dimensions.widthRatio(context, 85),
                          padding: EdgeInsets.only(
                            left: Dimensions.widthRatio(context, 8),
                            right: Dimensions.widthRatio(context, 8),
                            top: Dimensions.heightRatio(context, 2.25),
                            bottom: Dimensions.heightRatio(context, 0.5),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Dimensions.widthRatio(context, 68),
                                    child: TextField(
                                      focusNode: _focusNode,
                                      controller: _textController,
                                      textInputAction: TextInputAction.go,
                                      autofocus: true,
                                      onSubmitted: (_) => _submit(),
                                      cursorRadius: const Radius.circular(20),
                                      cursorColor: AppColors.primary,
                                      decoration: null,
                                      cursorOpacityAnimates: true,
                                      enableIMEPersonalizedLearning: false,
                                      enableSuggestions: false,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            Dimensions.fontSize30(context),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _submit,
                                    icon: Icon(
                                      Icons.arrow_circle_right_rounded,
                                      color: AppColors.primary,
                                      size: Dimensions.widthRatio(context, 12),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: Dimensions.heightRatio(context, 0.35),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Dimensions.heightRatio(context, 2.25)),
                    Text(
                      'Please enter the correct meaning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.fontSize(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: Dimensions.heightRatio(context, 2.25)),
                    Consumer<TypingViewModel>(
                      builder: (_, typingViewModel, __) {
                        final word =
                            typingViewModel.words[typingViewModel.currentIndex];
                        return FlipCard(
                          controller: _flipCardController,
                          direction: FlipDirection.VERTICAL,
                          front: BackgroundContainer(
                            widthRatio: 60,
                            heightRatio: 16,
                            borderRadius: 26,
                            color: Colors.white,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  word.engWord!.word ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.fontSize30(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          back: BackgroundContainer(
                            widthRatio: 60,
                            heightRatio: 16,
                            borderRadius: 26,
                            color: Colors.white,
                            borderColor: typingViewModel.isAnswerCorrect
                                ? AppColors.mainGreen
                                : AppColors.mainRed,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  word.userDefinition,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.fontSize30(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}
