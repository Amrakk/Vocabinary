import '../../data/topic.dart';
import '../../data/word.dart';

class InsideTopicArgs{
  final String topicId;
  final String topicName;
  final int wordCount;
  final TopicModel? topicModel;

  InsideTopicArgs({
    this.topicModel,
    required this.topicId,
    required this.topicName,
    required this.wordCount,
  });
}