import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/widgets/learnings/flashcard/flashcard_controller.dart';

class FlashcardViewModel extends ChangeNotifier {
  String? _topicID;
  int _currentIndex = -1;
  bool _isPlaying = false;
  List<WordModel> _words = [];
  final Set<String> _learnedWords = {};
  List<FlashcardController> _flashcardControllers = [];
  final AppinioSwiperController _cardSwiperController =
      AppinioSwiperController();

  void init(List<WordModel> words, {String? topicID}) {
    if (topicID != null) _topicID ??= topicID;
    _currentIndex = 0;
    _isPlaying = false;
    _learnedWords.clear();

    _words = words;

    if (_flashcardControllers.isEmpty) {
      _flashcardControllers =
          List.generate(words.length, (index) => FlashcardController());
    }
  }

  void clear() {
    _topicID = null;
    _currentIndex = -1;

    _words.clear();
    _learnedWords.clear();
    _flashcardControllers.clear();
  }

  bool get isPlaying => _isPlaying;
  Set<String> get learnedWords => _learnedWords;
  AppinioSwiperController get cardSwiperController => _cardSwiperController;
  List<FlashcardController> get flashcardControllers => _flashcardControllers;

  int get count => _words.length;
  List<WordModel> get words => _words;

  double get progress => _currentIndex / _words.length;

  void play() async {
    if (_isPlaying || _currentIndex >= count) return;
    _isPlaying = true;
    notifyListeners();

    if (!_flashcardControllers[_currentIndex].isFront()) {
      _flashcardControllers[_currentIndex].flipCard();
    }

    for (var i = _currentIndex; i < count; i++) {
      if (!_isPlaying) break;
      await _flashcardControllers[i].autoPlay();

      if (!_isPlaying) break;
      _flashcardControllers[i].setBorderColor(AppColors.mainRed);
      await _cardSwiperController.swipeDefault();

      if (!_isPlaying) break;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    pause();
  }

  void pause() {
    if (!_isPlaying) return;
    _isPlaying = false;
    notifyListeners();
  }

  bool updateCard(int index) {
    if (index > count) return false;

    _currentIndex = index;
    notifyListeners();

    return true;
  }

  void increasePoint(int index) {
    _words[index].point++;
    _learnedWords.add(_words[index].id!);
  }

  Future<List<bool>> save() async {
    final repo = WordRepo();
    final futures = _learnedWords
        .map(
          (word) => repo.updateWord(
            _topicID!,
            word,
            _words.firstWhere((element) => element.id == word),
          ),
        )
        .toList();
    return await Future.wait(futures);
  }
}
