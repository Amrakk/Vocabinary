import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vocabinary/models/arguments/explore/topic_args.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/views/explore/topic_view.dart';
import 'package:vocabinary/views/home/home_view.dart';
import 'package:vocabinary/views/learnings/quiz_view.dart';
import 'package:vocabinary/views/setting/setting_view.dart';
import 'package:vocabinary/views/explore/explore_view.dart';
import 'package:vocabinary/views/learnings/typing_view.dart';
import 'package:vocabinary/views/learnings/flashcard_view.dart';
import 'package:vocabinary/views/community/community_view.dart';
import 'package:vocabinary/views/learnings/select_type_view.dart';
import 'package:vocabinary/views/learnings/select_level_view.dart';
import 'package:vocabinary/models/arguments/learnings/select_words_args.dart';

import '../models/arguments/explore/folder_args.dart';
import '../models/arguments/explore/inside_topic_args.dart';
import '../views/explore/folder_view.dart';
import '../views/explore/inside_topic_view.dart';

class AppRoutes {
  static const initialRoute = '/';

  static final homeRoutes = ['/', '/explore', '/community', '/setting'];
  static final learningRoutes = [
    '/level',
    '/type',
    '/flashcard',
    '/quiz',
    '/typing',
  ];
  static final exploreRoutes = [
    '/topic',
    '/inside-topic',
    '/folder',
    'inside-folder'
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
      case '/quiz':
        args = args as SelectWordsArgs;
        var words = args.words;
        var topicID = args.topicID;
        return _buildPageTransition(
          QuizView(words: words, topicID: topicID),
          settings,
        );
      case '/typing':
        args = args as SelectWordsArgs;
        var words = args.words;
        var topicID = args.topicID;
        return _buildPageTransition(
          TypingView(words: words, topicID: topicID),
          settings,
        );
      case '/topic':
        args = args as TopicArguments;
        var userID = args.userID;
        var topics = args.topics;
        return _buildPageTransition(
          TopicView(userID: userID, topics: topics),
          settings,
        );
      case '/inside-topic':
        args = args as InsideTopicArgs;
        var topicID = args.topicId;
        var topicName = args.topicName;
        var wordCount = args.wordCount;
        return _buildPageTransition(
            InsideTopicView(
                topicID: topicID, topicName: topicName, wordCount: wordCount),
            settings);
      case '/folder':
        args = args as FolderArguments;
        var userID = args.userID;
        var folders = args.folders;
        return _buildPageTransition(
          FolderView(userID: userID, folders: folders),
          settings,
        );

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
