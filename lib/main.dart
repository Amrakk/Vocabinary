import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabinary/data/repositories/word_repo.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/helpers/dependencies.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vocabinary',
      theme: ThemeData(
        primarySwatch: AppColors.getMaterialColor(AppColors.primary),
        useMaterial3: false,
      ),
      // routes: AppRoutes.routes,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'test',
              style: TextStyle(
                fontSize: Dimensions.fontSize(context, 20),
              ),
            ),
          ),
          const Center(
            child: Text(
              'test',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // print(Dimensions.screenType);
            // print(Dimensions.screenWidth);
            // print(Dimensions.screenHeight(context));
            // print(Dimensions.height10(context));
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
