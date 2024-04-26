import 'package:flutter/material.dart';
import 'package:vocabinary/utils/enums.dart';

import '../../utils/dimensions.dart';

class TopicView extends StatefulWidget {
  const TopicView({super.key});

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  final _recentTopic = [
    {
      'Title': 'Outdoor Activity',
      'Description': 'Improve Vocabulary about Outdoor Activity',
      'wordCount': '10',
      'level': 'Easy',
      'public': false
    },
    {
      'Title': 'Water Sport',
      'Description': 'Improve Vocabulary about Water Sport',
      'wordCount': '10',
      'level': 'Easy',
      'public': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_to_photos_outlined),
        ),
        appBar: AppBar(
          title: Text("List Your Topic"),
          actions: [
            IconButton(
              onPressed: () {
                _showfilter(context);
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        body: GridView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _topicBuilder(context, _recentTopic),
                ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemNum,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10)),
      ),
    );
  }

  _topicBuilder(BuildContext context, List<Map<String, Object>> recentTopic) {
    return Container(
      height: 75,
      width: 200,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(1, 58, 99, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Outdoor Activity',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Improve Vocabulary about Outdoor Activity but it's too long to show like this",
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 9, color: Colors.white),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.format_list_bulleted),
                    Text("10",
                        style: TextStyle(fontSize: 9, color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Text("Easy",
                        style: TextStyle(fontSize: 9, color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.bookmark),
                    Text("12K",
                        style: TextStyle(fontSize: 9, color: Colors.white)),
                  ],
                ),
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
        var level = WordLevel.Easy;
        var wordNum = WordCount.MoreThan20;
        return AlertDialog(
          title: const Text("Filter Topic"),
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Level"),
                SizedBox(height: 10),
                Row(children: [
                  RadioMenuButton(
                      value: WordLevel.Easy,
                      groupValue: level,
                      onChanged: (WordLevel? value) {
                        setState(() {
                          level = value!;
                        });
                      },
                      child: Text("Easy")),
                  RadioMenuButton(
                      value: WordLevel.Medium,
                      groupValue: level,
                      onChanged: (WordLevel? value) {
                        setState(() {
                          level = value!;
                        });
                      },
                      child: Text("Medium")),
                  RadioMenuButton(
                      value: WordLevel.Hard,
                      groupValue: level,
                      onChanged: (WordLevel? value) {
                        setState(() {
                          level = value!;
                        });
                      },
                      child: Text("Hard")),
                ]),
                SizedBox(height: 10),
                Text("Number of Words"),
                SizedBox(height: 10),
                Row(children: [
                  RadioMenuButton(
                      value: WordCount.MoreThan20,
                      groupValue: wordNum,
                      onChanged: (WordCount? value) {
                        setState(() {
                          wordNum = value!;
                        });
                      },
                      child: Text(">20")),
                  RadioMenuButton(
                      value: WordCount.MoreThan50,
                      groupValue: wordNum,
                      onChanged: (WordCount? value) {
                        setState(() {
                          wordNum = value!;
                        });
                      },
                      child: Text(">50")),
                  RadioMenuButton(
                      value: WordCount.MoreThan100,
                      groupValue: wordNum,
                      onChanged: (WordCount? value) {
                        setState(() {
                          wordNum = value!;
                        });
                      },
                      child: Text(">100")),
                ]),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Apply")),
              ],
            ),
          ),
        );
      },
    );
  }
}
