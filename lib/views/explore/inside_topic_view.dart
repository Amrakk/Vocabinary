import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/viewmodels/explore/word_view_model.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/widgets/explore/inside_topic/item_vocab.dart';
import 'package:vocabinary/widgets/learnings/background_container.dart';
import 'package:vocabinary/widgets/learnings/confirm_button.dart';

import '../../models/arguments/explore/card_details_args.dart';
import '../../models/arguments/learnings/select_words_args.dart';
import '../../models/data/eng_word.dart';
import '../../models/data/word.dart';

class InsideTopicView extends StatefulWidget {
  const InsideTopicView(
      {Key? key,
      required this.topicID,
      required this.topicName,
      required this.wordCount})
      : super(key: key);
  final String topicID;
  final String topicName;
  final int wordCount;

  @override
  State<InsideTopicView> createState() => _InsideTopicViewState();
}

class _InsideTopicViewState extends State<InsideTopicView> {
  late WordViewModel _wordViewModel;
  late Future<void> _loadEngWordFuture;
  List<WordModel> words = [];
  List<EngWordModel> engWords = [];
  late int wordCount;

  @override
  void initState() {
    _wordViewModel = WordViewModel(widget.topicID);
    _loadEngWordFuture = _wordViewModel.getEngWords();
    wordCount = widget.wordCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.topicName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSize22(context),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const BackgroundLayer(ratio: 13),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthRatio(context, 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimensions.heightRatio(context, 12),
                  width: double.infinity,
                ),
                StreamBuilder(
                  stream: _wordViewModel.getWordsStream(widget.topicID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const BackgroundContainer(
                          heightRatio: 5,
                          widthRatio: 70,
                          borderRadius: 10,
                          color: Colors.white,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      if (snapshot.data == null) {
                        return const Center(child: Text('No data found!'));
                      }
                      words = snapshot.data!;
                      wordCount = words.length;
                      return BackgroundContainer(
                        heightRatio: 5,
                        widthRatio: 70,
                        borderRadius: 10,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Total Words was added: ${wordCount}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: Dimensions.fontSize16(context),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: Dimensions.heightRatio(context, 2.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Recent Cards',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: Dimensions.fontSize(context, 20),
                          ),
                        ),
                        SizedBox(width: Dimensions.widthRatio(context, 5)),
                        FloatingActionButton.small(
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed('/new-card')
                                .then((value) async {
                              _loadEngWordFuture = _wordViewModel.getEngWords();
                              setState(() {});
                            });
                          },
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Dimensions.widthRatio(context, 25),
                      height: Dimensions.heightRatio(context, 12),
                      child: Image.asset(
                        'assets/images/coach.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.heightRatio(context, 0.5)),
                SizedBox(
                  height: Dimensions.heightRatio(context, 54),
                  child: StreamBuilder(
                    stream: _wordViewModel.getWordsStream(widget.topicID),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // words = _wordViewModel.words;
                        if (snapshot.data == null) {
                          return const Center(child: Text('No data found!'));
                        }
                        words = snapshot.data!;
                        wordCount = words.length;
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pushNamed(
                                '/card-details',
                                arguments: CardDetailsArgs(
                                  topicID: widget.topicID,
                                  word: words[index],
                                ),
                              );
                            },
                            child: ItemVocab(
                              word: words[index],
                              engWord: words[index].engWord!,
                              topicID: widget.topicID,
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                              height: Dimensions.heightRatio(context, 1.75)),
                          itemCount: words.length,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: Dimensions.heightRatio(context, 3)),
                ConfirmButton(
                  widthRatio: 100,
                  label: 'Play',
                  iconSize: Dimensions.iconSize(context, 36),
                  fontSize: Dimensions.fontSize20(context),
                  leftIcon: Icons.play_circle_outline_outlined,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      '/level',
                      arguments: SelectWordsArgs(
                        words: words,
                        topicID: widget.topicID,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
