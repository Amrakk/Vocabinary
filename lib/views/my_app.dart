import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/data/caches/audio_cache_manager.dart';
import 'package:vocabinary/utils/app_themes.dart';
import 'package:vocabinary/viewmodels/theme_view_model.dart';
import 'package:vocabinary/widgets/my_app_bar.dart';
import 'package:vocabinary/views/home/home_view.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (_, themeViewModel, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vocabinary',
          darkTheme: AppThemes.darkTheme(),
          themeMode:
              themeViewModel.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: MyAppBar(),
      ),
      body: const HomeView(),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 25,
        inactiveColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
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
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        activeColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        activeIndex: _bottomBarIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: (index) => setState(() => _bottomBarIndex = index),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        onPressed: () {},
        tooltip: 'Add new word',
        child: const Icon(Icons.add),
      ),
    );
  }
}
