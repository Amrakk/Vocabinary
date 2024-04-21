import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vocabinary/models/arguments/learnings/select_words_args.dart';
import 'package:vocabinary/views/home/home_view.dart';
import 'package:vocabinary/views/explore/explore_view.dart';
import 'package:vocabinary/views/learnings/flashcard_view.dart';
import 'package:vocabinary/views/learnings/select_level_view.dart';
import 'package:vocabinary/views/learnings/select_type_view.dart';
import 'package:vocabinary/views/setting/setting_view.dart';
import 'package:vocabinary/views/community/community_view.dart';

class AppRoutes {
  static const initialRoute = '/';

  static final homeRoutes = ['/', '/explore', '/community', '/setting'];
  static final learningRoutes = [
    '/level',
    '/type',
    '/flashcard',
    '/quiz',
    '/typing',
    '/result'
  ];

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      // Home Routes
      case '/':
        return _buildPageTransition(const HomeView(), settings);
      case '/explore':
        return _buildPageTransition(const ExploreView(), settings);
      case '/community':
        return _buildPageTransition(const CommunityView(), settings);
      case '/setting':
        return _buildPageTransition(const SettingView(), settings);

      // Learning Routes
      case '/level':
        return _buildPageTransition(const SelectLevelView(), settings);
      case '/type':
        return _buildPageTransition(const SelectTypeView(), settings);
      case '/flashcard':
        args = args as SelectWordsArgs;
        var words = args.words;
        var topicID = args.topicID;

        return _buildPageTransition(
          FlashcardView(words: words, topicID: topicID),
          settings,
        );
      // case '/quiz':
      //   return _buildPageTransition(const QuizView(), settings);
      // case '/typing':
      //   return _buildPageTransition(const TypingView(), settings);
      // case '/result':
      //   return _buildPageTransition(const ResultView(), settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageTransition<dynamic> _buildPageTransition(
    Widget page,
    RouteSettings settings,
  ) {
    return PageTransition(
      child: page,
      duration: const Duration(milliseconds: 275),
      type: PageTransitionType.rightToLeft,
      settings: settings,
    );
  }
}
