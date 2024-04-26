import "package:flutter_dotenv/flutter_dotenv.dart";

class AppConstants {
  static String get apiKey => dotenv.get('API_KEY');

  static Map<String, int> learningTypes = {
    'flashcard': 1,
    'quiz': 5,
    'typing': 8
  };
}
