import '../../data/topic.dart';

class TopicArguments {
  final List<TopicModel> topics;
  final String userID;

  TopicArguments({required this.userID, required this.topics});
}
