import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_name_topic.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';

import '../../widgets/explore/create_new_card/item_topic_select.dart';

class CreateNewFolderView extends StatefulWidget {
  const CreateNewFolderView({super.key});

  @override
  State<CreateNewFolderView> createState() => _CreateNewFolderViewState();
}

class _CreateNewFolderViewState extends State<CreateNewFolderView> {
  bool isPublic = true;
  late Future<void> loadTopicsFuture;
  late ExploreViewModel exploreViewModel;
  List<String> selectedTopics = [];
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    exploreViewModel = Provider.of<ExploreViewModel>(context, listen: false);
    loadTopicsFuture = exploreViewModel.loadTopics();
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
                              'Create New Folder',
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
                // SizedBox(
                //   height: 42,
                //   child: FutureBuilder(future: loadTopicsFuture, builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else {
                //       final topics = exploreViewModel.topics;
                //       return ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: topics.length,
                //         itemBuilder: (context, index) {
                //           return Padding(
                //             padding: const EdgeInsets.only(right: 10),
                //             child: ItemTopicSelect(
                //               name: topics[index].name ?? '',
                //               id: topics[index].id ?? '',
                //               onTap: (topicID) {
                //                 setState(() {
                //                   if (selectedTopics.contains(topicID)) {
                //                     selectedTopics.remove(topicID);
                //                   } else {
                //                     selectedTopics.add(topicID);
                //                   }
                //                 });
                //               },
                //             ),
                //           );
                //         },
                //       );
                //     }
                //   }),
                // ),
                const Expanded(flex: 1,child: SizedBox(),),
                Button(nameButton: 'Create',onPressed: () async{
                  showLoadingIndicator(context);
                  if(nameController.text.isEmpty){
                    closeLoadingIndicator(context);
                    ShowSnackBar.showInfo("Please fill all fields", context);
                    return;
                  }
                  // Create new folder
                  final folder = FolderModel(
                    name: nameController.text,
                    topicIDs: selectedTopics,
                    ownerID: exploreViewModel.userID,
                    createdAt: Timestamp.fromDate(DateTime.now()),
                  );
                  await exploreViewModel.createFolder(folder);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },),
              ],
            ),
          )),
    );
  }

}
