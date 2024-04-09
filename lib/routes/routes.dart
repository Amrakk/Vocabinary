import 'package:flutter/material.dart';
import 'package:vocabinary/views/home/home_view.dart';
import 'package:vocabinary/views/explore/explore_view.dart';
import 'package:vocabinary/views/setting/setting_view.dart';
import 'package:vocabinary/views/community/community_view.dart';

class AppRoutes {
  static const initialRoute = '/';

  static final mainRoutes = {
    '/': (context) => const HomeView(),
    '/explore': (context) => const ExploreView(),
    '/community': (context) => const CommunityView(),
    '/setting': (context) => const SettingView(),
  };

  static Route<dynamic> generateMainRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/explore':
        return MaterialPageRoute(builder: (_) => const ExploreView());
      case '/community':
        return MaterialPageRoute(builder: (_) => const CommunityView());
      case '/setting':
        return MaterialPageRoute(builder: (_) => const SettingView());
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
}
