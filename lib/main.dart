import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/viewmodels/theme_view_model.dart';
import 'package:vocabinary/views/explore/inside_topic_view.dart';
import 'package:vocabinary/views/my_app.dart';
import 'package:vocabinary/helpers/dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeViewModel()),
  ], child: const MyApp()));
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
