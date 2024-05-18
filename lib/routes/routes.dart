import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vocabinary/models/arguments/explore/topic_args.dart';
import 'package:vocabinary/models/arguments/explore/update_card_args.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/views/explore/create_new_card_view.dart';
import 'package:vocabinary/views/explore/topic_view.dart';
import 'package:vocabinary/views/explore/update_card_view.dart';
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

import 'package:vocabinary/models/arguments/explore/folder_args.dart';
import 'package:vocabinary/models/arguments/explore/topic_args.dart';
import 'package:vocabinary/views/authenticate/forgot_password_view.dart';
import 'package:vocabinary/views/authenticate/register_view.dart';
import 'package:vocabinary/views/explore/folder_view.dart';
import 'package:vocabinary/views/explore/inside_topic_view.dart';

import 'package:vocabinary/views/authenticate/login_view.dart';
import 'package:vocabinary/views/explore/topic_view.dart';
import '../models/arguments/explore/card_details_args.dart';
import '../models/arguments/explore/folder_args.dart';
import '../models/arguments/explore/inside_topic_args.dart';
import '../views/explore/card_details_view.dart';
import '../views/explore/create_new_folder_view.dart';
import '../views/explore/folder_view.dart';
import '../views/explore/inside_topic_view.dart';
import 'package:vocabinary/widgets/setting/about_page.dart';
import 'package:vocabinary/models/arguments/explore/inside_topic_args.dart';
import 'package:vocabinary/models/arguments/explore/update_card_args.dart';
import 'package:vocabinary/views/community/inside_topic_community_view.dart';
import 'package:vocabinary/views/explore/create_new_card_view.dart';
import 'package:vocabinary/views/explore/update_card_view.dart';
import 'package:vocabinary/widgets/setting/change_password.dart';
import 'package:vocabinary/widgets/setting/my_account_page.dart';

import '../views/explore/update_folder_view.dart';

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
    'inside-folder',
    '/create-folder',
    '/create-topic',
  ];
  static final authRoutes = ['/login', '/register', '/forgot-password'];
  static final communityRoutes = ['/community/inside-topic'];
  static final settingRoutes = [
    '/setting/about',
    '/setting/my-account',
    '/setting/my-account/change-password',
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
        var enableButtonAdd = args.enableButtonAdd ?? true;
        var isCommunity = args.isCommunity ?? false;
        return _buildPageTransition(
          TopicView(
              userID: userID, topics: topics, buttonAddTopic: enableButtonAdd, isCommunity: isCommunity,),
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
      case '/card-details':
        args = args as CardDetailsArgs;
        var topicID = args.topicID;
        var word = args.word;
        return _buildPageTransition(
            CardDetailsView(topicID: topicID, word: word), settings);
      case '/new-card':
        return _buildPageTransition(const CreateNewCardView(), settings);
      case '/update-card':
        args = args as UpdateCardArgs;
        var topicID = args.topicID;
        var word = args.word;
        return _buildPageTransition(UpdateCardView(topicID: topicID, word: word), settings);
      case '/folder':
        args = args as FolderArguments;
        var userID = args.userID;
        var folders = args.folders;
        return _buildPageTransition(
          FolderView(userID: userID, folders: folders),
          settings,
        );
      case '/inside-folder':
        args = args as InsideFolderArgs;
        var folder = args.folder;
        return _buildPageTransition(
          InsideFolderView(
            folder: folder,
          ),
          settings,
        );
      case '/create-folder':
        return _buildPageTransition(const CreateNewFolderView(), settings);
      case '/create-topic':
        return _buildPageTransition(const CreateNewTopicView(), settings);
        case '/update-folder':
        args = args as InsideFolderArgs;
        var folder = args.folder;
        return _buildPageTransition(
          UpdateFolderView(
            folder: folder,
          ),
          settings,
        );
      // Community Routes
      case '/community/inside-topic':
        args = args as InsideTopicArgs;
        var topicID = args.topicId;
        var topicName = args.topicName;
        var wordCount = args.wordCount;
        var topic = args.topicModel;
        return _buildPageTransition(
            InsideTopicCommunityView(
              topicID: topicID,
              topicName: topicName,
              wordCount: wordCount,
              topicModel: topic!,
            ),
            settings);

      // Authentication Routes
      case '/login':
        return _buildPageTransition(const LoginView(), settings,
            type: PageTransitionType.leftToRight);
      case '/register':
        return _buildPageTransition(
          const SignUpView(),
          settings,
        );
      case '/forgot-password':
        return _buildPageTransition(const ForgotPasswordView(), settings);

      // Setting Routes
      case '/setting/about':
        return _buildPageTransition(const AboutPage(), settings);
      case '/setting/my-account':
        return _buildPageTransition(const MyAccountPage(), settings);
      case '/setting/my-account/change-password':
        return _buildPageTransition(const ChangePasswordPage(), settings);

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
      Widget page, RouteSettings settings,
      {PageTransitionType? type}) {
    type = type ?? PageTransitionType.rightToLeft;
    return PageTransition(
      child: page,
      duration: const Duration(milliseconds: 275),
      type: type,
      settings: settings,
    );
  }
}
