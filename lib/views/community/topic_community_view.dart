import 'package:flutter/material.dart';
import 'package:vocabinary/routes/routes.dart';
import 'package:vocabinary/utils/enums.dart';
import 'package:vocabinary/utils/filter/decorator.dart';
import 'package:vocabinary/utils/filter/topic_list.dart';
import 'package:vocabinary/widgets/community/item_community_card.dart';
import 'package:vocabinary/widgets/explore/custom_radio_button.dart';

import '../../models/arguments/explore/inside_topic_args.dart';
import '../../models/data/topic.dart';
import '../../utils/dimensions.dart';

class ListTopicCommunityView extends StatefulWidget {
   ListTopicCommunityView({Key? key, this.isCommunity ,this.buttonAddTopic, required this.topics, required this.userID})
      : super(key: key);
  final List<TopicModel> topics;
  final String userID;
  bool? buttonAddTopic;
  bool? isCommunity;

  @override
  State<ListTopicCommunityView> createState() => _ListTopicCommunityViewState();
}


class _ListTopicCommunityViewState extends State<ListTopicCommunityView> {
  var level = TopicLevel.Default;
  var wordNum = WordNum.Default;
  var publicity = Publicity.Private;
  List<TopicModel> filteredTopics = [];

  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.buttonAddTopic ?? true ? FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.exploreRoutes[5]);
            },
          child: const Icon(Icons.add),
        ) : null,
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
        body: (widget.topics.isEmpty)
            ? _emptyTopic(context)
            : Padding(
                padding: const EdgeInsets.all(10),
                child: filterIsDefault() ?  GridView.builder(
                  itemCount:  widget.topics.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(
                        '/inside-topic',
                        arguments: InsideTopicArgs(
                          topicId: widget.topics[index].id!,
                          topicName: widget.topics[index].name!,
                          wordCount: widget.topics[index].wordCount,
                        ),
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _topicBuilder(
                            context,
                        widget.topics[index])),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: itemNum,
                      childAspectRatio: Dimensions.screenType(context) == ScreenType.Small ? 1/1.6 : 1/1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20
                  ),
                ) : filteredTopics.isEmpty
                    ? _emptyTopic(context)
                    : GridView.builder(
                        itemCount: filteredTopics.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              '/inside-topic',
                              arguments: InsideTopicArgs(
                                topicId: widget.topics[index].id!,
                                topicName: widget.topics[index].name!,
                                wordCount: widget.topics[index].wordCount,
                              ),
                            );
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _topicBuilder(context, filteredTopics[index])),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: itemNum,
                            childAspectRatio: Dimensions.screenType(context) == ScreenType.Small ? 1/1.6 : 1/1.45,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20
                        )
                ),
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
      filteredList = TopicLevelFilterDecorator(filteredList, wordLevelToInt(level));
    }
    if (wordNum != WordNum.Default) {
      filteredList =
          TopicWordNumFilterDecorator(filteredList, wordNumConverter(wordNum));
    }
    if (publicity != Publicity.Private) {
      filteredList = TopicPublicFilterDecorator(filteredList, isPublic(publicity));
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
