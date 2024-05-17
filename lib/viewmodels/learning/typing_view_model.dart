import 'dart:async';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/data/repositories/learning_repo.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/data/repositories/user_topic_log_repo.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/helpers/string_helper.dart';
import 'package:vocabinary/models/data/learning.dart';
import 'package:vocabinary/models/data/user_topic_log.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/utils/constants.dart';
import 'package:vocabinary/views/learnings/typing_view.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';

class TypingViewModel extends ChangeNotifier {
  String? _topicID;
  int _score = 0;
  int _totalScore = 0;
  int _currentIndex = 0;
  bool _isRunning = false;
  bool _isAnswerCorrect = false;
  Timestamp? _endTime;
  Timestamp? _startTime;

  TypingViewState? _state;
  List<WordModel> _words = [];
  final Set<String> _correctWords = {};
  final TextEditingController _textController = TextEditingController();
  final FlipCardController _flipCardController = FlipCardController();

  Timer? timer;
  int seconds = max;
  static const max = 15;

  void init(List<WordModel> words, {String? topicID}) {
    _score = 0;
    _currentIndex = 0;
    _words = words;
    _topicID = topicID;
    _startTime = Timestamp.now();

    _correctWords.clear();
    for (var word in _words) {
      _totalScore += word.level;
    }
  }

  void setViewState(TypingViewState state) {
    _state = state;
  }

  void clear() {
    _score = 0;
    _totalScore = 0;
    _currentIndex = -1;
    _state = null;
    _topicID = null;
    _endTime = null;
    _startTime = null;
    _isRunning = false;
    _isAnswerCorrect = false;

    _words.clear();
    timer?.cancel();
    _correctWords.clear();
  }

  int get score => _score;
  int get count => _words.length;
  int get totalScore => _totalScore;
  int get currentIndex => _currentIndex;

  bool get isRunning => _isRunning;
  bool get isAnswerCorrect => _isAnswerCorrect;

  double get progress => _currentIndex / _words.length;

  List<WordModel> get words => _words;
  Set<String> get correctWords => _correctWords;
  TextEditingController get textController => _textController;
  FlipCardController get flipCardController => _flipCardController;
  Duration get duration => _endTime!.toDate().difference(_startTime!.toDate());

  bool isCorrect(int index) => _correctWords.contains(_words[index].id);
  void increatePoint(WordModel word) {
    word.point += AppConstants.learningTypes['typing']!;
    _correctWords.add(word.id!);

    _score += word.level;
  }

  Future<void> next(String answer) async {
    _isRunning = true;
    stopTimer();

    _isAnswerCorrect = toLowerCaseNonAccentVietnamese(answer) ==
        toLowerCaseNonAccentVietnamese(_words[currentIndex].userDefinition);
    notifyListeners();

    if (_isAnswerCorrect) increatePoint(_words[currentIndex]);

    await Future.delayed(const Duration(milliseconds: 450));
    await _flipCardController.toggleCard();
    await Future.delayed(const Duration(milliseconds: 2750));
    await _flipCardController.toggleCard();

    _textController.clear();

    _currentIndex++;
    if (_currentIndex == count) {
      _state!.onDone();
      return;
    }
    await Future.delayed(const Duration(milliseconds: 275));
    notifyListeners();

    _isRunning = false;
    startTimer();
  }

  Future<List<dynamic>> save() async {
    _endTime = Timestamp.now();

    LearningModel result = LearningModel(
      score: _score,
      learningType: 'typing',
      start: _startTime,
      finish: _endTime,
    );

    String userID = AuthenticationService.instance.currentUser!.uid;
    var futures = <Future<dynamic>>[];

    if (await TopicRepo().isTopicOwner(_topicID!, userID)) {
      futures = _correctWords
          .map(
            (word) => WordRepo().updateWord(
              _topicID!,
              word,
              _words.firstWhere((element) => element.id == word),
            ),
          )
          .toList();
    }

    final learningRepo = LearningRepo();
    final userTopicLogRepo = UserTopicLogRepo();

    final userLog =
        await userTopicLogRepo.getUserTopicLogByUserID(_topicID!, userID);

    if (userLog == null) {
      final newUserLog = UserTopicLogModel(
        userID: userID,
        learnedCount: 1,
        lastAccess: _endTime,
        learnings: [result],
      );

      final userLogId =
          await userTopicLogRepo.createUserTopicLog(_topicID!, newUserLog);
      futures.add(learningRepo.createLearning(_topicID!, userLogId!, result));
    } else {
      await userLog.loadLearnings(_topicID!);

      userLog.learnedCount++;
      userLog.lastAccess = _endTime;

      final bestLearning = userLog.learnings
          .where((element) => element.learningType == 'typing');
      if (bestLearning.isNotEmpty) {
        if (bestLearning.first.compareTo(result) <= 0) {
          futures.add(
            learningRepo.updateLearning(
                _topicID!, userLog.id!, bestLearning.first.id!, result),
          );
        }
      } else {
        futures.add(
          learningRepo.createLearning(_topicID!, userLog.id!, result),
        );
      }

      futures.add(
        userTopicLogRepo.updateUserTopicLog(_topicID!, userLog.id!, userLog),
      );
    }

    return await Future.wait(futures);
  }

  void startTimer({bool reset = true}) async {
    if (reset) resetTimer();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        seconds--;
        notifyListeners();
      } else {
        stopTimer(isTimeout: true);
      }
    });
  }

  void stopTimer({bool isTimeout = false}) async {
    if (isTimeout) {
      await next('');
      return;
    }
    timer?.cancel();
  }

  void resetTimer() {
    seconds = max;
  }
}
