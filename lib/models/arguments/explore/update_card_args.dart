import 'package:vocabinary/models/data/word.dart';

class UpdateCardArgs{
  final String topicID;
  final WordModel word;

  UpdateCardArgs({
    required this.topicID,
    required this.word,
  });
}