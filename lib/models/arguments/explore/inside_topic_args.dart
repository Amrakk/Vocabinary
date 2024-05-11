import '../../data/word.dart';

class InsideTopicArgs{
  final String topicId;
  final String topicName;
  final int wordCount;

  InsideTopicArgs({
    required this.topicId,
    required this.topicName,
    required this.wordCount,
  });
}