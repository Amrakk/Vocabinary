import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/arguments/explore/update_topic_args.dart';
import 'package:vocabinary/routes/routes.dart';
import 'package:vocabinary/utils/enums.dart';
import 'package:vocabinary/utils/filter/decorator.dart';
import 'package:vocabinary/utils/filter/topic_list.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/widgets/community/item_community_card.dart';
import 'package:vocabinary/widgets/explore/custom_radio_button.dart';

import '../../models/arguments/explore/inside_topic_args.dart';
import '../../models/data/topic.dart';
import '../../utils/dimensions.dart';

class TopicView extends StatefulWidget {
  TopicView(
      {Key? key,
      this.isCommunity,
      this.buttonAddTopic,
      required this.topics,
      required this.userID})
      : super(key: key);
  final List<TopicModel> topics;
  final String userID;
  bool? buttonAddTopic;
  bool? isCommunity;

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  var level = TopicLevel.Default;
  var wordNum = WordNum.Default;
  var publicity = Publicity.Private;
  List<TopicModel> filteredTopics = [];
  List<TopicModel> topics = [];

  late Stream<List<TopicModel>> topicsStream;
  late ExploreViewModel _exploreViewModel;

  @override
  void initState() {
    _exploreViewModel = Provider.of<ExploreViewModel>(context, listen: false);
    topicsStream = _exploreViewModel.getTopicsStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.buttonAddTopic ?? true
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.exploreRoutes[5]);
                },
                child: const Icon(Icons.add),
              )
            : null,
        appBar: AppBar(
          title: const Text("List Topic"),
          actions: [
            IconButton(
              onPressed: () {
                _showfilter(context);
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        body: StreamBuilder<Object>(
          stream: _exploreViewModel.getTopicsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              topics = snapshot.data as List<TopicModel>;
              // print(topics);
              if (topics.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: filterIsDefault()
                      ? GridView.builder(
                          itemCount: topics.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Action",
                                        textAlign: TextAlign.center),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                //confirm delete
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Delete Topic"),
                                                        content: const Text(
                                                            "Are you sure you want to delete this topic?"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Cancel")),
                                                          TextButton(
                                                              onPressed: () {
                                                                _exploreViewModel
                                                                    .deleteTopic(
                                                                        topics[index]
                                                                            .id!);
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Delete"))
                                                        ],
                                                      );
                                                    });
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xFF0248C2)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)))),
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    "/update-topic",
                                                    arguments: UpdateTopicArgs(
                                                        data: widget
                                                            .topics[index]));
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xFF0248C2)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)))),
                                              child: const Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
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
                                child: _topicBuilder(context, topics[index])),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: itemNum,
                                  childAspectRatio:
                                      Dimensions.screenType(context) ==
                                              ScreenType.Small
                                          ? 1 / 1.6
                                          : 1 / 1.5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20),
                        )
                      : filteredTopics.isEmpty
                          ? _emptyTopic(context)
                          : GridView.builder(
                              itemCount: filteredTopics.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Action",
                                                textAlign: TextAlign.center),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        //confirm delete
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Delete Topic"),
                                                                content: const Text(
                                                                    "Are you sure you want to delete this topic?"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          "Cancel")),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        _exploreViewModel
                                                                            .deleteTopic(filteredTopics[index].id!);
                                                                        Navigator.pop(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          "Delete"))
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(const Color(
                                                                      0xFF0248C2)),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)))),
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pushNamed(
                                                            "/update-topic",
                                                            arguments:
                                                                UpdateTopicArgs(
                                                                    data: filteredTopics[index]));
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(const Color(
                                                                      0xFF0248C2)),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)))),
                                                      child: const Text(
                                                        "Edit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: _topicBuilder(
                                            context, filteredTopics[index])),
                                  ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: itemNum,
                                      childAspectRatio:
                                          Dimensions.screenType(context) ==
                                                  ScreenType.Small
                                              ? 1 / 1.6
                                              : 1 / 1.45,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20)),
                );
              } else {
                return _emptyTopic(context);
              }
            }
          },
        ),
      ),
    );
  }

  _topicBuilder(BuildContext context, TopicModel topic) {
    return CommunityCard(
      topic: topic,
      disableGesture: widget.isCommunity ?? false ? false : true,
    );
  }

  _showfilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Level",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  MyRadioListTile(
                      value: TopicLevel.Easy,
                      groupValue: level,
                      onChanged: (TopicLevel? value) {
                        setState(() {
                          level = value!;
                        });
                      },
                      leading: "Easy"),
                  MyRadioListTile(
                      value: TopicLevel.Medium,
                      groupValue: level,
                      onChanged: (TopicLevel? value) {
                        setState(() {
                          level = value!;
                        });
                      },
                      leading: "Medium"),
                  MyRadioListTile(
                      value: TopicLevel.Hard,
                      groupValue: level,
                      onChanged: (TopicLevel? value) {
                        setState(() {
                          level = value!;
                        });
                      },
                      leading: "Hard"),
                ]),
                const SizedBox(height: 10),
                const Text("Owner",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyRadioListTile(
                        value: Publicity.Private,
                        groupValue: publicity,
                        onChanged: (Publicity? value) {
                          setState(() {
                            publicity = value!;
                          });
                        },
                        leading: "Private"),
                    MyRadioListTile(
                        value: Publicity.Public,
                        groupValue: publicity,
                        onChanged: (Publicity? value) {
                          setState(() {
                            publicity = value!;
                          });
                        },
                        leading: "Public"),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Number of Words",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyRadioListTile(
                          value: WordNum.MoreThan20,
                          groupValue: wordNum,
                          onChanged: (WordNum? value) {
                            setState(() {
                              wordNum = value!;
                            });
                          },
                          leading: ">20"),
                      MyRadioListTile(
                          value: WordNum.MoreThan50,
                          groupValue: wordNum,
                          onChanged: (WordNum? value) {
                            setState(() {
                              wordNum = value!;
                            });
                          },
                          leading: ">50"),
                      MyRadioListTile(
                          value: WordNum.MoreThan100,
                          groupValue: wordNum,
                          onChanged: (WordNum? value) {
                            setState(() {
                              wordNum = value!;
                            });
                          },
                          leading: ">100"),
                    ]),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          applyFilters(TopicList(widget.topics));
                          Navigator.pop(context);
                          this.setState(() {});
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF0248C2)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: const Text(
                          "Apply",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // reset all the filter to default
                          level = TopicLevel.Default;
                          wordNum = WordNum.Default;
                          publicity = Publicity.Private;
                          setState(() {});
                          this.setState(() {});
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF0248C2)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: const Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _emptyTopic(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/empty_folder.png'),
          ),
          Text("No result were found"),
        ],
      ),
    );
  }

  void applyFilters(TopicList topicList) {
    TopicList filteredList = TopicList(widget.topics);
    if (level != TopicLevel.Default) {
      print(wordLevelToInt(level));
      filteredList =
          TopicLevelFilterDecorator(filteredList, wordLevelToInt(level));
    }
    if (wordNum != WordNum.Default) {
      filteredList =
          TopicWordNumFilterDecorator(filteredList, wordNumConverter(wordNum));
    }
    if (publicity != Publicity.Private) {
      filteredList =
          TopicPublicFilterDecorator(filteredList, isPublic(publicity));
    }
    filteredTopics = filteredList.topics;
  }

  int wordNumConverter(WordNum wordNum) {
    switch (wordNum) {
      case WordNum.MoreThan20:
        return 20;
      case WordNum.MoreThan50:
        return 50;
      case WordNum.MoreThan100:
        return 100;
      default:
        return 0;
    }
  }

  bool isPublic(Publicity publicity) {
    return publicity == Publicity.Public;
  }

  bool filterIsDefault() {
    return level == TopicLevel.Default &&
        wordNum == WordNum.Default &&
        publicity == Publicity.Private;
  }
}
