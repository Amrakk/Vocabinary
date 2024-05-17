import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/viewmodels/community/community_view_model.dart';
import 'package:vocabinary/widgets/global/avatar_mini.dart';
import 'package:vocabinary/widgets/global/button.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/widgets/shimmer/item_vocab_loading.dart';
import 'package:vocabinary/widgets/explore/inside_topic/item_vocab.dart';
import 'package:vocabinary/models/arguments/learnings/select_words_args.dart';

class InsideTopicCommunityView extends StatefulWidget {
  InsideTopicCommunityView(
      {required this.wordCount,
      required this.topicName,
      required this.topicID,
      required this.topicModel,
      super.key});

  String topicID;
  String topicName;
  int wordCount;
  TopicModel topicModel;

  @override
  State<InsideTopicCommunityView> createState() =>
      _InsideTopicCommunityViewState();
}

class _InsideTopicCommunityViewState extends State<InsideTopicCommunityView> {
  late CommunityViewModel _communityViewModel;
  List<WordModel> listWords = [];
  bool isLoading = true;
  late bool? isOwner;
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _communityViewModel =
          Provider.of<CommunityViewModel>(context, listen: false);
      listWords = await _communityViewModel.getAllWordsByTopic(widget.topicID);
      isOwner =
          await _communityViewModel.isTopicOwner(widget.topicID, AuthenticationService.instance.currentUser!.uid);
      isFollowing =
          await _communityViewModel.isFollowing(widget.topicModel, AuthenticationService.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(
              widget.topicModel.imageTopic!,
              fit: BoxFit.fill,
            )),
        Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black26,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          color: myColors.containerColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                            color: myColors.containerColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : isFollowing
                                    ? GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                           await _communityViewModel.unfollowTopic(
                                              widget.topicModel,
                                               AuthenticationService.instance.currentUser!.uid
                                           );
                                          setState(() {
                                            isLoading = false;
                                            isFollowing = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.bookmark_added_rounded,
                                          size: 30,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await _communityViewModel
                                              .followTopic(widget.topicModel,
                                                  AuthenticationService.instance.currentUser!.uid);
                                          setState(() {
                                            isLoading = false;
                                            isFollowing = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.bookmark_add_outlined,
                                          size: 30,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    widget.topicName,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarMini(),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                            child: Text(
                          widget.wordCount.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 35, right: 35, top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 400,
                          child: SingleChildScrollView(
                              child: SizedBox(
                            height: MediaQuery.of(context).size.height - 420,
                            child: listWords.isEmpty
                                ? ListView.separated(
                                    itemBuilder: (context, index) {
                                      return const ItemVocabLoading();
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                    itemCount: 3)
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ItemVocab(
                                        word: listWords[index],
                                        isEditable: isOwner,
                                        engWord: listWords[index].engWord!,
                                        topicID: widget.topicID,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                    itemCount: listWords.length),
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                            nameButton: "Play!",
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pushNamed(
                                '/level',
                                arguments: SelectWordsArgs(
                                  words: listWords,
                                  topicID: widget.topicID,
                                ),
                              );
                            },
                            isLoading: listWords.isEmpty ? true : false,
                            icon: const Icon(
                              Icons.play_circle_outline,
                              size: 25,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ],
    ));
  }
}
