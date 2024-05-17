
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/viewmodels/explore/create_word_view_model.dart';
import 'package:vocabinary/viewmodels/explore/explore_view_model.dart';
import 'package:vocabinary/viewmodels/explore/word_view_model.dart';
import 'package:vocabinary/widgets/explore/create_new_card/item_topic_select.dart';
import 'package:vocabinary/widgets/explore/create_new_card/slider_level.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_description_topic.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/explore/create_new_card/input_vocab_card.dart';

import '../../services/firebase/authentication_service.dart';

class CreateNewCardView extends StatefulWidget {
  const CreateNewCardView({super.key});

  @override
  State<CreateNewCardView> createState() => _CreateNewCardViewState();
}

class _CreateNewCardViewState extends State<CreateNewCardView> {
  late Future<void> _loadTopicsFuture;
  late ExploreViewModel exploreViewModel;
  late WordViewModel wordViewModel;
  late CreateWordViewModel createWordViewModel;
  int _currentLevel = 1;
  final exampleTextController = TextEditingController();
  final vocabNameController = TextEditingController();
  final vocabDefinitionController = TextEditingController();
  List<String> selectedTopics = [];
  EngWordModel engWord = EngWordModel();

  @override
  void initState() {
    String userID = AuthenticationService.instance.currentUser?.uid ?? '';
    // userID = '4VtPfzFkETVqg29YJdpW';
    exploreViewModel = ExploreViewModel(userID);
    wordViewModel = WordViewModel();
    _loadTopicsFuture = exploreViewModel.loadTopics();

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
                        child: InputVocabCard(
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
                  SliderLevel(
                    currentLevel: _currentLevel,
                    onLevelChanged: (v) {
                      setState(() {
                        _currentLevel = v;
                      });
                    },
                  ),
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
                          //TODO: Add image picker
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
                    child: FutureBuilder(
                      future: _loadTopicsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var topics = exploreViewModel.topics;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: topics.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ItemTopicSelect(
                                  name: topics[index].name ?? '',
                                  id: topics[index].id ?? '',
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
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Button(
                      nameButton: "Create",
                      onPressed: () async {
                        showLoadingDialog(context);
                        createWordViewModel =
                            CreateWordViewModel(topics: selectedTopics);
                        if (selectedTopics.isNotEmpty) {
                          WordModel word = WordModel(
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
                          await createWordViewModel.addWord(word);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a topic'),
                            ),
                          );
                        }
                        //pop the dialog and current screen
                      }),
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
