import "package:flutter_dotenv/flutter_dotenv.dart";

class AppConstants {
  static String get apiKey => dotenv.get('API_KEY');
}
