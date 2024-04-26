import 'package:vocabinary/models/data/word.dart';

class SelectWordsArgs {
  final List<WordModel> words;
  final String topicID;

  SelectWordsArgs({
    required this.words,
    required this.topicID,
  });
}
