import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/arguments/explore/inside_folder_args.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/utils/enums.dart';
import 'package:vocabinary/utils/filter/folder_list.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/widgets/explore/custom_radio_button.dart';
import 'package:vocabinary/widgets/explore/folder_builder.dart';

import '../../utils/dimensions.dart';
import '../../utils/filter/decorator.dart';

class FolderView extends StatefulWidget {
  const FolderView({Key? key, required this.folders, required this.userID})
      : super(key: key);
  final List<FolderModel> folders;
  final String userID;

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  var topicNum = TopicNum.Default;
  List<FolderModel> filteredFolders = [];
  List<FolderModel> folders = [];
  late ExploreViewModel _exploreViewModel;

  @override
  void initState() {
    _exploreViewModel = Provider.of<ExploreViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = Dimensions.screenWidth(context);
    var itemNum = screenWidth ~/ 200;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //generate route
            Navigator.of(context).pushNamed("/create-folder");
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
            : StreamBuilder(
                stream: isDefaultFilter()
                    ? _exploreViewModel.getFoldersStream()
                    : _exploreViewModel
                        .getFoldersStreamByTopicNum(topicNumToInt(topicNum)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    folders = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: folders.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _folderBuilder(context, folders[index]),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: itemNum,
                            childAspectRatio: Dimensions.screenType(context) ==
                                    ScreenType.Medium
                                ? 1 / 1.9
                                : 1 / 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                      ),
                    );
                  }
                }),
      ),
    );
  }

  _folderBuilder(BuildContext context, FolderModel folder) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed("/inside-folder", arguments: InsideFolderArgs(folder));
      },
      onLongPressStart: (details) {
        final offset = details.globalPosition;
        showMenu(
          items: <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                title: const Text("Delete"),
                leading: const Icon(Icons.delete),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Folder"),
                        content: const Text(
                            "Are you sure you want to delete this folder?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _exploreViewModel.deleteFolder(folder.id!);
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                title: const Text("Edit"),
                leading: const Icon(Icons.edit),
                onTap: () {
                  Navigator.of(context).pushNamed("/update-folder",
                      arguments: InsideFolderArgs(folder));
                },
              ),
            ),
          ],
          context: context,
          // right bottom
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy,
            MediaQuery.of(context).size.width - offset.dx,
            MediaQuery.of(context).size.height - offset.dy,
          ),
        );
      },
      child: FolderCard(
        folder: folder,
      ),
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
                const Text("Number of Topics",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(children: [
                  MyRadioListTile(
                      value: TopicNum.MoreThan5,
                      groupValue: topicNum,
                      onChanged: (TopicNum? value) {
                        setState(() {
                          topicNum = value!;
                        });
                      },
                      leading: ">5"),
                  MyRadioListTile(
                      value: TopicNum.MoreThan10,
                      groupValue: topicNum,
                      onChanged: (TopicNum? value) {
                        setState(() {
                          topicNum = value!;
                        });
                      },
                      leading: ">10"),
                  MyRadioListTile(
                      value: TopicNum.MoreThan20,
                      groupValue: topicNum,
                      onChanged: (TopicNum? value) {
                        setState(() {
                          topicNum = value!;
                        });
                      },
                      leading: ">20"),
                ]),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
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
                          topicNum = TopicNum.Default;
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

  bool isDefaultFilter() {
    return topicNum == TopicNum.Default;
  }

  int topicNumToInt(TopicNum level) {
    switch (level) {
      case TopicNum.MoreThan5:
        return 5;
      case TopicNum.MoreThan10:
        return 10;
      case TopicNum.MoreThan20:
        return 20;
      default:
        return 0;
    }
  }
}
