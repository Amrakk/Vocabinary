import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/models/data/topic.dart';

import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/utils/enums.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/viewmodels/explore/word_view_model.dart';
import 'package:vocabinary/widgets/community/item_community_card.dart';
import 'package:vocabinary/widgets/explore/folder_builder.dart';

import '../../models/arguments/explore/folder_args.dart';
import '../../models/arguments/explore/inside_topic_args.dart';
import '../../models/arguments/explore/topic_args.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  late ExploreViewModel _viewModel;
  late Future<void> _loadTopicsFuture;
  late Future<void> _loadFoldersFuture;
  late Future<void> _loadRecentActivitiesFuture;
  late Future<void> _loadRecentActivitiesDestinationFuture;

  void init() {
    _viewModel = Provider.of<ExploreViewModel>(context, listen: false);
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    _viewModel.setUserID(uid);
    _loadTopicsFuture = _viewModel.loadTopics();
    _loadFoldersFuture = _viewModel.loadFolders();
    _loadRecentActivitiesDestinationFuture =
        _viewModel.loadRecentActivitiesDestination();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Explore',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF03045E),
                    borderRadius: BorderRadius.circular(48),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Wrap(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: Dimensions.fontSize(context, 22),
                                  color: Colors.white,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'Boost Your Vocabulary In ',
                                  ),
                                  TextSpan(
                                    text: 'Today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 140,
                        height: 110,
                        child: Image(
                          image: AssetImage(
                            'assets/images/explore.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Recently Activity",
                      style: TextStyle(fontSize: 25),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: Future.wait([
                    // _loadRecentActivitiesFuture,
                    _loadRecentActivitiesDestinationFuture
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: SizedBox(
                          height: 100,
                          child: Text(
                              'An error occurred when loading recent activity.'),
                        ),
                      );
                    } else {
                      var recentActivity = _viewModel.recentTopics;
                      var destination = _viewModel.recentTopicsDestination;
                      if (recentActivity.isEmpty) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text('No recent activity found.'),
                          ),
                        );
                      } else {
                        return Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemNum < recentActivity.length
                                ? itemNum
                                : recentActivity.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  '/inside-topic',
                                  arguments: InsideTopicArgs(
                                    topicId: recentActivity[index].id!,
                                    topicName: recentActivity[index].name!,
                                    wordCount: recentActivity[index].wordCount,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: _activityBuilder(context,
                                    recentActivity[index], destination[index]),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
                Row(
                  children: [
                    const Text(
                      "Browser By Your Topic",
                      style: TextStyle(fontSize: 25),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    IconButton(
                        onPressed: () {
                          //navigate to topic and send topics data
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(
                            '/topic',
                            arguments: TopicArguments(
                              userID: 'userID',
                              topics: _viewModel.topics,
                            ),
                          )
                              .then((value) {
                            setState(() {
                              init();
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: _loadTopicsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: SizedBox(
                            height: 100,
                            child:
                                Text('An error occurred when loading topics.')),
                      );
                    } else {
                      var topics = _viewModel.topics;
                      if (topics.isEmpty) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text('No topics found.'),
                          ),
                        );
                      } else {
                        return Container(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemNum < topics.length
                                ? itemNum
                                : topics.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  '/inside-topic',
                                  arguments: InsideTopicArgs(
                                    topicId: topics[index].id!,
                                    topicName: topics[index].name!,
                                    wordCount: topics[index].wordCount,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: _topicBuilder(context, topics[index]),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text(
                      "Browser By Your Folder",
                      style: TextStyle(fontSize: 25),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            '/folder',
                            arguments: FolderArguments(
                              userID: 'userID',
                              folders: _viewModel.folders,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                    future: _loadFoldersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: SizedBox(
                              height: 100,
                              child: Text(
                                  'An error occurred when loading folders.')),
                        );
                      } else {
                        var folders = _viewModel.folders;
                        if (folders.isEmpty) {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text('No folder found.'),
                            ),
                          );
                        } else {
                          return Container(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: itemNum < folders.length
                                  ? itemNum
                                  : folders.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(
                                    '/folder',
                                    arguments: FolderArguments(
                                      userID: 'userID',
                                      folders: _viewModel.folders,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child:
                                      _folderBuilder(context, folders[index]),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _activityBuilder(BuildContext context, recentActivity, destination) {
    return Container(
      height: 75,
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF013A63),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recentActivity.name ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            recentActivity.description ?? '',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                size: 10,
              ),
              Text(
                recentActivity.createdAtString,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.folder,
                size: 10,
              ),
              Text(
                destination ?? '',
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _topicBuilder(BuildContext context, TopicModel topic) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordViewModel(topic.id!))
      ],
      child: CommunityCard(
        topic: topic,
        disableGesture: true,
      ),
    );
  }

  String followerCount(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 1000000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
  }

  _folderBuilder(BuildContext context, FolderModel folder) {
    return FolderCard(folder: folder);
  }
}
