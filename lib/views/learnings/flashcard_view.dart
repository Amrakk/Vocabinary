import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:vocabinary/widgets/progress_bar.dart';
import 'package:vocabinary/widgets/my_icon_button.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/widgets/learnings/confirm_button.dart';
import 'package:vocabinary/widgets/learnings/flashcard/flashcard.dart';
import 'package:vocabinary/viewmodels/learning/flashcard_view_model.dart';
import 'package:vocabinary/widgets/learnings/flashcard/flashcard_controller.dart';

class FlashcardView extends StatefulWidget {
  final String topicID;
  final List<WordModel> words;
  const FlashcardView({super.key, required this.words, required this.topicID});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  late FlashcardViewModel _flashcardViewModel;
  late AppinioSwiperController _cardSwiperController;
  late List<FlashcardController> _flashcardControllers;

  void init() {
    widget.words.shuffle();

    _flashcardViewModel =
        Provider.of<FlashcardViewModel>(context, listen: false);
    _flashcardViewModel.init(widget.words, topicID: widget.topicID);
    _flashcardControllers = _flashcardViewModel.flashcardControllers;
    _cardSwiperController = _flashcardViewModel.cardSwiperController;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _flashcardViewModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: handle disable/dialog for back button
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
                'Reviewing Vocabulary',
                style: TextStyle(
                  fontSize: Dimensions.fontSize18(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: Dimensions.height(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<FlashcardViewModel>(
                    builder: (_, flashcardViewModel, __) => Text(
                      _flashcardViewModel.progress < 1
                          ? '${_flashcardViewModel.count} words'
                          : 'Done',
                      style: TextStyle(
                        fontSize: Dimensions.fontSize(context, 15),
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width(context, 14)),
                  Consumer<FlashcardViewModel>(
                    builder: (_, flashcardViewModel, __) {
                      return SizedBox(
                        width: Dimensions.widthRatio(context, 40),
                        child: ProgressBar(
                          height: Dimensions.height(context, 10),
                          duration: 300,
                          value: flashcardViewModel.progress,
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
          const BackgroundLayer(ratio: 40),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Dimensions.heightRatio(context, 15)),

              // swiper
              SizedBox(
                height: Dimensions.heightRatio(context, 65),
                width: Dimensions.widthRatio(context, 90),
                child: FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 350)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return AppinioSwiper(
                      controller: _cardSwiperController,
                      defaultDirection: AxisDirection.left,
                      allowUnSwipe: true,
                      onSwipeEnd: _onSwipeEnd,
                      onEnd: _onEnd,
                      backgroundCardCount: 0,
                      onCardPositionChanged: (position) {
                        if (position.index == _flashcardViewModel.count) return;
                        if (_flashcardViewModel.isPlaying) {
                          _flashcardViewModel.pause();
                        }
                        if (position.offset.dx > 0) {
                          _flashcardControllers[position.index]
                              .setBorderColor(AppColors.mainGreen);
                        } else if (position.offset.dx < 0) {
                          _flashcardControllers[position.index]
                              .setBorderColor(AppColors.mainRed);
                        } else {
                          _flashcardControllers[position.index]
                              .setBorderColor(Colors.transparent);
                        }
                      },
                      threshold: 100,
                      cardCount: _flashcardViewModel.count,
                      swipeOptions:
                          const SwipeOptions.symmetric(horizontal: true),
                      maxAngle: 0,
                      loop: false,
                      duration: Duration(
                        milliseconds: _flashcardViewModel.isPlaying ? 650 : 550,
                      ),
                      backgroundCardScale: 0.0,
                      cardBuilder: (context, index) {
                        return Flashcard(
                          key: ValueKey(_flashcardViewModel.words[index].id),
                          controller: _flashcardControllers[index],
                          word: _flashcardViewModel.words[index],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: Dimensions.heightRatio(context, 5)),

              //   // functional buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyIconButton(
                    onTap: () async {
                      if (_flashcardViewModel.isPlaying) {
                        _flashcardViewModel.pause();
                      }
                      await _cardSwiperController.unswipe();
                    },
                    icon: Icons.replay_rounded,
                    size: Dimensions.iconSize(context, 60),
                  ),
                  MyIconButton(
                    onTap: () async {
                      if (_flashcardViewModel.isPlaying) {
                        _flashcardViewModel.pause();
                      }

                      widget.words.shuffle();
                      _flashcardViewModel.init(widget.words);
                      setState(() {});
                    },
                    icon: Icons.shuffle_rounded,
                    size: Dimensions.iconSize(context, 60),
                  ),
                  Consumer<FlashcardViewModel>(
                    builder: (_, flashcardViewModel, __) => MyIconButton(
                      onTap: flashcardViewModel.isPlaying
                          ? flashcardViewModel.pause
                          : flashcardViewModel.play,
                      icon: flashcardViewModel.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: Dimensions.iconSize(context, 60),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  FutureOr<bool> _onSwipeEnd(int prev, int target, SwiperActivity activity) {
    _flashcardViewModel.updateCard(target);

    // Unswipe
    if (prev >= _flashcardViewModel.count || target < prev) return true;

    // Set border color
    if (activity.currentOffset.dx == 0) {
      _flashcardControllers[prev].setBorderColor(Colors.transparent);
    }

    // Swipe right
    if (activity.direction == AxisDirection.right) {
      _flashcardViewModel.increasePoint(prev);
    }

    return true;
  }

  void _onEnd() async {
    await Future.delayed(const Duration(milliseconds: 750), () async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF4A4A4A),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Dimensions.heightRatio(context, 30),
                width: double.infinity,
                child: Image.asset(
                  'assets/images/finish_flashcard.png',
                  fit: BoxFit.cover,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'CONGRATULATIONS!',
                  style: TextStyle(
                    color: const Color(0xFFFFD8BE),
                    fontSize: Dimensions.fontSize30(context),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height(context, 4)),
              Text(
                'You have memorized',
                style: TextStyle(
                  color: const Color(0xFFFFD8BE),
                  fontSize: Dimensions.fontSize20(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: Dimensions.height10(context)),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${_flashcardViewModel.learnedWords.length}/${_flashcardViewModel.count} Words',
                  style: TextStyle(
                    color: const Color(0xFFFFD8BE),
                    fontSize: Dimensions.fontSize(context, 40),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height30(context)),
              ConfirmButton(
                label: 'Finish',
                borderRadius: 16,
                fontSize: Dimensions.fontSize20(context),
                onPressed: () => Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ),
              )
            ],
          ),
        ),
      );
      await _flashcardViewModel.save();
    });
  }
}
