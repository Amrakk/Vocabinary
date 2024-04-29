import 'package:vocabinary/utils/filter/topic_list.dart';

import '../../models/data/topic.dart';

class TopicListDecorator extends TopicList {
  final TopicList _topicList;

  TopicListDecorator(this._topicList) : super(_topicList.topics);

  @override
  List<TopicModel> get topics => _topicList.topics;

  @override
  set topics(List<TopicModel> newTopics) {
    _topicList.topics = newTopics;
  }
}
