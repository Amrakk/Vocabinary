import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/utils/enums.dart';
import 'package:vocabinary/widgets/explore/custom_radio_button.dart';

import '../../utils/dimensions.dart';

class FolderView extends StatefulWidget {
  const FolderView({Key? key, required this.folders, required this.userID})
      : super(key: key);
  final List<FolderModel> folders;
  final String userID;

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: const Icon(Icons.add_to_photos_outlined),
        ),
        appBar: AppBar(
          title: const Text("List Your Folder"),
          actions: [
            IconButton(
              onPressed: () {
                _showfilter(context);
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        body: widget.folders.isEmpty
            ? _emptyFolder(context)
            : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: widget.folders.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _folderBuilder(context, widget.folders[index]),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: itemNum,
                      childAspectRatio: 2 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                ),
              ),
      ),
    );
  }

  _folderBuilder(BuildContext context, FolderModel folder) {
    return Container(
      height: 75,
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF023E8A),
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
          Center(
            child: Text(
              folder.name!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.format_list_bulleted),
                  Text(folder.topicIDs.length.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  Text(folder.createdAtFormatted,
                      style: const TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
            ],
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
        var numFlashCard = AmountOfFlashCards.Default;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Level",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    MyRadioListTile(
                        value: WordLevel.Easy,
                        groupValue: level,
                        onChanged: (WordLevel? value) {
                          setState(() {
                            level = value!;
                          });
                        },
                        leading: "Easy"),
                    MyRadioListTile(
                        value: WordLevel.Medium,
                        groupValue: level,
                        onChanged: (WordLevel? value) {
                          setState(() {
                            level = value!;
                          });
                        },
                        leading: "Medium"),
                    MyRadioListTile(
                        value: WordLevel.Hard,
                        groupValue: level,
                        onChanged: (WordLevel? value) {
                          setState(() {
                            level = value!;
                          });
                        },
                        leading: "Hard")
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Number of Flash Cards",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(children: [
                  MyRadioListTile(
                      value: AmountOfFlashCards.MoreThan20,
                      groupValue: numFlashCard,
                      onChanged: (AmountOfFlashCards? value) {
                        setState(() {
                          numFlashCard = value!;
                        });
                      },
                      leading: ">20"),
                  MyRadioListTile(
                      value: AmountOfFlashCards.MoreThan50,
                      groupValue: numFlashCard,
                      onChanged: (AmountOfFlashCards? value) {
                        setState(() {
                          numFlashCard = value!;
                        });
                      },
                      leading: ">50"),
                  MyRadioListTile(
                      value: AmountOfFlashCards.MoreThan100,
                      groupValue: numFlashCard,
                      onChanged: (AmountOfFlashCards? value) {
                        setState(() {
                          numFlashCard = value!;
                        });
                      },
                      leading: ">100"),
                ]),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                          level = WordLevel.Easy;
                          numFlashCard = AmountOfFlashCards.Default;
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

  _emptyFolder(BuildContext context) {
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
