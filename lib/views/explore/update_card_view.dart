import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/viewmodels/explore/create_word_view_model.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/viewmodels/explore/word_view_model.dart';
import 'package:vocabinary/views/explore/explore_view.dart';
import 'package:vocabinary/widgets/explore/create_new_card/item_topic_select.dart';
import 'package:vocabinary/widgets/explore/create_new_card/slider_level.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_description_topic.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/explore/create_new_card/input_vocab_card.dart';

import '../../services/firebase/authentication_service.dart';
import '../../widgets/explore/update_card/vocab_card.dart';

class UpdateCardView extends StatefulWidget {
  const UpdateCardView({super.key, this.topicID, required this.word});

  final topicID;
  final WordModel word;

  @override
  State<UpdateCardView> createState() => _UpdateCardViewState();
}

class _UpdateCardViewState extends State<UpdateCardView> {
  late ExploreViewModel exploreViewModel;
  late WordViewModel wordViewModel;
  late int _currentLevel;
  final exampleTextController = TextEditingController();
  final vocabNameController = TextEditingController();
  final vocabDefinitionController = TextEditingController();
  EngWordModel engWord = EngWordModel();

  @override
  void initState() {
    String userID = AuthenticationService.instance.currentUser?.uid ?? '';
    userID = '4VtPfzFkETVqg29YJdpW';
    exploreViewModel = ExploreViewModel(userID);
    wordViewModel = WordViewModel(widget.topicID);
    vocabNameController.text = widget.word.engWord?.word ?? '';
    vocabDefinitionController.text = widget.word.userDefinition ?? '';
    exampleTextController.text = widget.word.description ?? '';
    _currentLevel = widget.word.level ?? 1;
    super.initState();
  }

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
                        child: VocabCard(
                          vocabNameController: vocabNameController,
                          vocabDefinitionController: vocabDefinitionController,
                          saveButtonFunction:
                              (vocabName, vocabDefinition, engWord) {
                            vocabNameController.text = vocabName;
                            vocabDefinitionController.text = vocabDefinition;
                            this.engWord = engWord;
                          },
                        ),
                      ),
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
                  SliderLevel(currentLevel: _currentLevel,onLevelChanged: (v){
                    setState(() {
                      _currentLevel = v;
                    });
                  },),
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
                    height: 15,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Button(
                    nameButton: "Update",
                    onPressed: () async {
                      showLoadingDialog(context);
                      WordModel word = WordModel(
                        id: widget.word.id,
                        userDefinition: vocabDefinitionController.text,
                        engWordID: '',
                        description: exampleTextController.text,
                        illustration: '',
                        level: _currentLevel,
                        isFavorite: false,
                        point: 0,
                        engWord: engWord,
                      );
                      //show a CircularProgressIndicator and add the word to the database
                      await wordViewModel.updateWord(word);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
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
