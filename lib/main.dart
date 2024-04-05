import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/helpers/dependencies.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocabinary/utils/themeData.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:vocabinary/views/home/home_view.dart';
import 'package:vocabinary/widgets/app_bar_app.dart';
import 'package:vocabinary/widgets/home/search_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await init();

  var wordStream = WordRepo().wordsStream('wIEzPcEYaaCwzCrNghTh');
  wordStream.listen((event) {
    print(event);
  });

  runApp(const MyApp());
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vocabinary',
      theme: ThemeData(
        primarySwatch: AppColors.getMaterialColor(AppColors.primary),
        useMaterial3: true,
      ),
      darkTheme: MyThemeData.dark(),
      themeMode: ThemeMode.dark,
      // routes: AppRoutes.routes,
      home: MyHomePage(title: 'Learning Something New Everyday!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _bottomBarIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: appBarApp(context),
      ),
      body: const HomeView(),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 25,
        inactiveColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        icons: const [
          Icons.home,
          Icons.folder_copy_rounded,
          Icons.people_alt_rounded,
          Icons.settings,
        ],
        shadow: const BoxShadow(
          color: Colors.black,
          blurRadius: 5,
        ),
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        activeColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        activeIndex: _bottomBarIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: (index) => setState(() => _bottomBarIndex = index),
        //other params
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        onPressed: () {
        },
        tooltip: 'Add new word',
        child: const Icon(Icons.add),
      ),
    );
  }
}
