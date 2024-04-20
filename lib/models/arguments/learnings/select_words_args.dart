import 'package:vocabinary/models/data/word.dart';

class SelectWordsArgs {
  final List<WordModel> words;

  SelectWordsArgs({required this.words});

  @override
  String toString() {
    return 'SelectWordsArgs{words: $words}';
  }
}
