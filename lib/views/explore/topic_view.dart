import 'package:flutter/material.dart';
import 'package:vocabinary/utils/enums.dart';
import 'package:vocabinary/widgets/explore/custom_radio_button.dart';

import '../../models/data/topic.dart';
import '../../utils/dimensions.dart';

class TopicView extends StatefulWidget {
  const TopicView({Key? key, required this.topics, required this.userID})
      : super(key: key);
  final List<TopicModel> topics;
  final String userID;

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {

  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //navigate to add topic
          },
          child: const Icon(Icons.add_to_photos_outlined),
        ),
        appBar: AppBar(
          title: const Text("List Your Topic"),
          actions: [
            IconButton(
              onPressed: () {
                _showfilter(context);
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        body: widget.topics.isEmpty
            ? _emptyTopic(context)
            : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: widget.topics.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _topicBuilder(context, widget.topics[index]),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: itemNum,
                      childAspectRatio: 2/1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                ),
              ),
      ),
    );
  }

  _topicBuilder(BuildContext context,TopicModel topic) {
    return Container(
      height: 75,
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF00324E),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            topic.name!,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            topic.description!,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, color: Colors.white),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          const Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.format_list_bulleted),
                    Text(topic.wordCount.toString(),
                        style: const TextStyle(fontSize: 9, color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star),
                    Text(intLevelToString(topic.level),
                        style: const TextStyle(fontSize: 9, color: Colors.white)),
                  ],
                ),
                topic.isPublic
                    ?
                Row(
                  children: [
                    const Icon(Icons.bookmark),
                    Text(topic.followers.length.toString(),
                        style: const TextStyle(fontSize: 9, color: Colors.white)),
                    ],
                )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showfilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        var level = TopicLevel.Default;
        var wordNum = WordNum.Default;
        var publicity = Publicity.Private;
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
                Text("Owner", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyRadioListTile(value: Publicity.Private, groupValue: publicity, onChanged: (Publicity? value){
                      setState(() {
                        publicity = value!;
                      });
                    }, leading: "Private"),
                    MyRadioListTile(value: Publicity.Public, groupValue: publicity, onChanged: (Publicity? value){
                      setState(() {
                        publicity = value!;
                      });
                    }, leading: "Public"),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Apply",style: TextStyle(color: Colors.white),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF0248C2)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
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
}
