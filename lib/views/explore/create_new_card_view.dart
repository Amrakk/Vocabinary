import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocabinary/widgets/explore/create_new_card/item_topic_select.dart';
import 'package:vocabinary/widgets/explore/create_new_card/slider_level.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_description_topic.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/explore/create_new_card/input_vocab_card.dart';

class CreateNewCardView extends StatefulWidget {
  const CreateNewCardView({super.key});

  @override
  State<CreateNewCardView> createState() => _CreateNewCardViewState();
}

class _CreateNewCardViewState extends State<CreateNewCardView> {
  int _currentLevel = 1;
  final exampleTextController = TextEditingController();
  final vocabNameController = TextEditingController();
  final vocabDefinitionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                            'Add Your Own Card',
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
                          child: InputVocabCard(
                            vocabNameController: vocabNameController,
                            vocabDefinitionController:
                                vocabDefinitionController,
                            saveButtonFunction: () {
                              print('Save button pressed');
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.padding20(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SliderLevel(currentLevel: _currentLevel),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Add to example",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputDescriptionTopic(
                    textDescriptionController: exampleTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Upload image",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      height: Dimensions.heightRatio(context, 22),
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Add image picker
                        },
                        child: SvgPicture.asset(
                          'assets/images/upload.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Add to your topic",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ItemTopicSelect(
                            name: 'Economic',
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 15,
                          );
                        },
                        itemCount: 10),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Button(
                    nameButton: "Create",
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
