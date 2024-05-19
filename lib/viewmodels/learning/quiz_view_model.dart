import 'package:flutter/material.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/constants.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabinary/models/data/learning.dart';
import 'package:vocabinary/models/data/user_topic_log.dart';
import 'package:vocabinary/widgets/learnings/quiz/quiz.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/data/repositories/topic_repo.dart';
import 'package:vocabinary/data/repositories/learning_repo.dart';
import 'package:vocabinary/data/repositories/user_topic_log_repo.dart';

class QuizViewModel extends ChangeNotifier {
  String? _topicID;
  int _score = 0;
  int _totalScore = 0;
  int _currentIndex = 0;
  Timestamp? _startTime;
  Timestamp? _endTime;

  List<Quiz> _quizzes = [];
  List<WordModel> _words = [];
  final Set<String> _correctWords = {};
  final Map<String, int> _optionMaps = {};
  final PageController _pageController = PageController();

  void init(List<WordModel> words, {String? topicID}) {
    _score = 0;
    _currentIndex = 0;
    _words = words;
    print(words.length);
    print(words.length);
    print(words.length);
    _topicID = topicID;
    _startTime = Timestamp.now();

    _correctWords.clear();
    for (var word in _words) {
      _totalScore += word.level;
      _optionMaps[word.id!] = 0;
    }
    _quizzes = _buildQuizzes();
  }

  void clear() {
    _score = 0;
    _totalScore = 0;
    _currentIndex = -1;
    _topicID = null;
    _startTime = null;
    _endTime = null;

    _words.clear();
    _quizzes.clear();
    _optionMaps.clear();
    _correctWords.clear();
  }

  int get score => _score;
  int get totalScore => _totalScore;

  int get count => _words.length;
  List<Quiz> get quizzes => _quizzes;
  List<WordModel> get words => _words;
  int get currentIndex => _currentIndex;
  Set<String> get correctWords => _correctWords;
  double get progress => _currentIndex / _words.length;
  PageController get pageController => _pageController;
  Duration get duration => _endTime!.toDate().difference(_startTime!.toDate());

  bool isCorrect(int index) => _correctWords.contains(_words[index].id);
  void increasePoint(WordModel word) {
    word.point += AppConstants.learningTypes['quiz']!;
    _correctWords.add(word.id!);

    _score += word.level;
  }

  void next() {
    if (_currentIndex < count - 1) {
      _currentIndex++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    notifyListeners();
  }

  void done() {
    _currentIndex++;
    notifyListeners();
  }

  Future<List<dynamic>> save() async {
    _endTime = Timestamp.now();

    LearningModel result = LearningModel(
      score: _score,
      learningType: 'quiz',
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

      final bestLearning =
          userLog.learnings.where((element) => element.learningType == 'quiz');
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

  List<Quiz> _buildQuizzes() {
    return _words.map((word) {
      return Quiz(
        level: word.level,
        question: word.engWord!.word ?? '',
        answer: word.userDefinition,
        options: _buildOptions(word.id!),
        onRight: () => increasePoint(word),
      );
    }).toList();
  }

  List<String> _buildOptions(String wordID) {
    final List<String> options = [];

    final List<WordModel> randomWords = _words
        .where(
            (word) => word.id != wordID && _optionMaps.keys.contains(word.id))
        .where((word) => _optionMaps[word.id]! < 4)
        .toList()
      ..shuffle();

    randomWords
        .sort((a, b) => _optionMaps[a.id]!.compareTo(_optionMaps[b.id]!));

    for (var i = 0; i < 3; i++) {
      options.add(randomWords[i].userDefinition);
      _optionMaps[randomWords[i].id!] = _optionMaps[randomWords[i].id!]! + 1;
    }

    options.shuffle();

    return options;
  }
}
