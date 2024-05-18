import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_description_topic.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_name_topic.dart';

import '../../widgets/explore/create_new_card/item_topic_select.dart';

class UpdateFolderView extends StatefulWidget {
  const UpdateFolderView({super.key, required this.folder});
  final FolderModel folder;

  @override
  State<UpdateFolderView> createState() => _UpdateFolderViewState();
}

class _UpdateFolderViewState extends State<UpdateFolderView> {
  bool isPublic = true;
  late Future<void> loadTopicsFuture;
  late ExploreViewModel exploreViewModel;
  List<String> selectedTopics = [];
  final nameController = TextEditingController();

  @override
  void initState() {
    exploreViewModel = Provider.of<ExploreViewModel>(context, listen: false);
    loadTopicsFuture = exploreViewModel.loadTopics();
    nameController.text = widget.folder.name ?? '';
    selectedTopics = widget.folder.topicIDs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: Dimensions.heightRatio(context, 35),
                floating: true,
                snap: true,
                flexibleSpace: PreferredSize(
                    preferredSize:
                        Size.fromHeight(Dimensions.heightRatio(context, 35)),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF003566),
                                Color(0xFF006FD6),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          child: AppBar(
                            title: const Text(
                              'Edit Folder',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Positioned(
                          bottom: Dimensions.heightRatio(context, -5),
                          left: MediaQuery.of(context).size.width / 2 -
                              Dimensions.widthRatio(context, 30),
                          child: InputTopicName(
                              textNameController: nameController),
                        ),
                      ],
                    )),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.all(Dimensions.padding30(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.heightRatio(context, 6)),
                SizedBox(
                  height: 42,
                  child: FutureBuilder(future: loadTopicsFuture, builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final topics = exploreViewModel.topics;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ItemTopicSelect(
                              name: topics[index].name ?? '',
                              id: topics[index].id ?? '',
                              isSelected: selectedTopics.contains(topics[index].id),
                              onTap: (topicID) {
                                setState(() {
                                  if (selectedTopics.contains(topicID)) {
                                    selectedTopics.remove(topicID);
                                  } else {
                                    selectedTopics.add(topicID);
                                  }
                                });
                              },
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
                const Expanded(child: SizedBox(),flex: 1,),
                Button(nameButton: 'Save',onPressed: () async{
                  showLoadingDialog(context);
                  // Create new folder
                  final folder = FolderModel(
                    name: nameController.text,
                    topicIDs: selectedTopics,
                    ownerID: exploreViewModel.userID,
                    createdAt: Timestamp.fromDate(DateTime.now()),
                  );
                  await exploreViewModel.updateFolder(widget.folder.id!, folder);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);

                },),
              ],
            ),
          )),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          content: Row(
            children: [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
