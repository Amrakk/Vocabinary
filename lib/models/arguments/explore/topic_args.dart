import '../../data/topic.dart';

class TopicArguments {
  final List<TopicModel> topics;
  final String userID;
  final bool? enableButtonAdd;
  final bool? isCommunity;

  TopicArguments({required this.userID, this.enableButtonAdd, this.isCommunity ,required this.topics});
}
