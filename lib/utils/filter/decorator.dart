import 'package:vocabinary/utils/filter/topic_decorator.dart';

import '../../models/data/folder.dart';
import '../../models/data/topic.dart';
import 'folder_decorator.dart';

class TopicLevelFilterDecorator extends TopicListDecorator {
  final int difficulty;

  TopicLevelFilterDecorator(super.wrappedList, this.difficulty);

  @override
  List<TopicModel> get topics {
    return super.topics.where((topic) => topic.level == difficulty).toList();
  }
}

class TopicPublicFilterDecorator extends TopicListDecorator {
  final bool isPublic;

  TopicPublicFilterDecorator(super.wrappedList, this.isPublic);

  @override
  List<TopicModel> get topics {
    return super.topics.where((topic) => topic.isPublic).toList();
  }
}

class TopicWordNumFilterDecorator extends TopicListDecorator {
  final int numberOfWords;

  TopicWordNumFilterDecorator(super.wrappedList, this.numberOfWords);

  @override
  List<TopicModel> get topics {
    return super.topics.where((topic) => topic.wordCount > numberOfWords).toList();
  }
}

class FolderTopicNumFilterDecorator extends FolderDecorator {
  final int numberOfTopics;

  FolderTopicNumFilterDecorator(super.wrappedList, this.numberOfTopics);

  @override
  List<FolderModel> get folders {
    return super.folders.where((folder) => folder.topicIDs.length > numberOfTopics).toList();
  }
}