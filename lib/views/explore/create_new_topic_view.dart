import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/api_responses/imgbb_api_res.dart';
import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/services/api/img_api.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/widgets/explore/create_new_card/slider_level.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_description_topic.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_name_topic.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';

import 'package:vocabinary/models/data/folder.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/item_folder_select.dart';

class CreateNewTopicView extends StatefulWidget {
  const CreateNewTopicView({super.key});

  @override
  State<CreateNewTopicView> createState() => _CreateNewTopicViewState();
}

class _CreateNewTopicViewState extends State<CreateNewTopicView> {
  bool isPublic = true;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  Uint8List? imageBytes;
  late TopicModel topic;
   ExploreViewModel? _exploreViewModel;
  int currentLevel = 1;
  String folderID = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _exploreViewModel = Provider.of<ExploreViewModel>(context, listen: false);
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
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
                              'Create New Topic',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.heightRatio(context, 6)),
                  SliderLevel(
                      currentLevel: currentLevel,
                      onLevelChanged: (value) {
                        setState(() {
                          currentLevel = value;
                        });
                      }
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 3)),
                  Text(
                    'Add to description',
                    style: TextStyle(
                        fontSize: Dimensions.fontSize(context, 22),
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 2)),
                  InputDescriptionTopic(
                    textDescriptionController: descriptionController,
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 3)),
                  Text(
                    'Upload cover photo',
                    style: TextStyle(
                        fontSize: Dimensions.fontSize(context, 22),
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 2)),
                  Center(
                    child: SizedBox(
                      height: Dimensions.heightRatio(context, 22),
                      child: GestureDetector(
                        onTap: () async {
                           await ImageService.pickImage().then((value) {
                            setState(()  {
                              imageBytes = value;
                            });
                          });
                        },
                        child: imageBytes == null ? SvgPicture.asset(
                          'assets/images/upload.svg',
                          fit: BoxFit.contain,
                        ) : Image.memory(
                          imageBytes!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            ShowSnackBar.showError("Error loading image", context);
                              imageBytes = null;
                            return SvgPicture.asset(
                              'assets/images/upload.svg',
                              fit: BoxFit.contain,
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Public Topic',
                        style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 22),
                            fontWeight: FontWeight.normal),
                      ),
                      CupertinoSwitch(
                          value: isPublic,
                          onChanged: (value) {
                            setState(() {
                              isPublic = value;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 3)),
                  Text(
                    'Select Folder',
                    style: TextStyle(
                        fontSize: Dimensions.fontSize(context, 22),
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 2.5)),
                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _exploreViewModel != null ? _exploreViewModel!.folders
                          .map((folder) => Row(
                            children: [
                              ItemFolderSelect(
                                    name: folder.name!,
                                    id: folder.id!,
                                    isSelected: folderID == folder.id,
                                    onTap: (id) {
                                      setState(() {
                                        folderID = id;
                                      });
                                    },
                                  ),
                                  SizedBox(width: Dimensions.widthRatio(context, 2)),
                            ],
                          ))
                          .toList() : [],
                    ),
                  ),
                  SizedBox(height: Dimensions.heightRatio(context, 5)),
                  Button(
                      nameButton: 'Apply',
                      onPressed: () async {
                        if(nameController.text.isEmpty || descriptionController.text.isEmpty || imageBytes == null || folderID.isEmpty) {
                          ShowSnackBar.showInfo("Please fill all fields", context);
                          return;
                        }
                        showLoadingIndicator(context);
                        final myImage = await ImageService.uploadImage(imageBytes!);
                        if(myImage == null) {
                          ShowSnackBar.showError("Error uploading image", context);
                          closeLoadingIndicator(context);
                          return;
                        }
                          topic = TopicModel(
                            name: nameController.text,
                            description: descriptionController.text,
                            isPublic: isPublic,
                            createdAt: Timestamp.now(),
                            ownerID: AuthenticationService.instance.currentUser!.uid,
                            level: currentLevel,
                            imageTopic: myImage.image,
                          );
                          String? topicId = await _exploreViewModel!.createTopicReturnId(topic);
                          if(topicId == null) {
                            ShowSnackBar.showError("Error creating topic", context);
                            closeLoadingIndicator(context);
                            return;
                          }
                          await _exploreViewModel!.addTopicToFolder(folderID, topicId!).then((value) {
                            if(value) {
                              closeLoadingIndicator(context);
                              ShowSnackBar.showSuccess("Topic created successfully", context);
                              Navigator.pop(context);
                            } else {
                              ShowSnackBar.showError("Error adding topic to folder", context);
                              closeLoadingIndicator(context);
                            }
                          });

                      }

                  ),
                ],
              ),
            ),
          )),
    );
  }
}
