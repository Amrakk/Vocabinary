import 'package:vocabinary/models/data/word.dart';

class CardDetailsArgs{
  final String topicID;
  final WordModel word;

  CardDetailsArgs({required this.topicID, required this.word});
}