import '../../models/data/topic.dart';

class TopicList{
  List<TopicModel> _topics;

  TopicList(this._topics);

  // Get the list of topics
  List<TopicModel> get topics => _topics;

  // Set a new list of topics
  set topics(List<TopicModel> newTopics) {
    _topics = newTopics;
  }
}