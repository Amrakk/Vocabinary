import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/viewmodels/explore/word_view_model.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/widgets/explore/inside_topic/item_vocab.dart';
import 'package:vocabinary/widgets/learnings/background_container.dart';
import 'package:vocabinary/widgets/learnings/confirm_button.dart';
import 'package:vocabinary/widgets/level_star_bar.dart';

import '../../models/arguments/learnings/select_words_args.dart';
import '../../models/data/eng_word.dart';
import '../../models/data/word.dart';
import '../../widgets/audio_button/audio_button.dart';

class CardDetailsView extends StatefulWidget {
  const CardDetailsView({Key? key, required this.topicID, required this.word})
      : super(key: key);
  final String topicID;
  final WordModel word;

  @override
  State<CardDetailsView> createState() => _CardDetailsViewState();
}

class _CardDetailsViewState extends State<CardDetailsView> {
  late WordViewModel _wordViewModel;
  late Future<void> _loadEngWordFuture;
  List<WordModel> words = [];
  List<EngWordModel> engWords = [];

  @override
  void initState() {
    _wordViewModel = WordViewModel(widget.topicID);
    _loadEngWordFuture = _wordViewModel.getEngWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.word.engWord!.word ?? "",
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
              vertical: Dimensions.heightRatio(context, 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimensions.heightRatio(context, 13),
                  width: double.infinity,
                ),
                Container(
                  width: Dimensions.widthRatio(context, 85),
                  padding: EdgeInsets.all(Dimensions.padding20(context)),
                  decoration: BoxDecoration(
                    color: Color(0xff023e8a),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x89000000),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.word.engWord!.word ?? "",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSize30(context),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "English Definition",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSize(context, 16),
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                          AudioButton(
                            word: widget.word.engWord?.word ?? "",
                            url: widget.word.engWord?.audio ?? "",
                          ),
                        ],
                      ),
                      LevelStarBar(
                          level: widget.word.level,
                          size: Dimensions.widthRatio(context, 6.75),
                          color: Color(0xffffc300)),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.heightRatio(context, 3)),
                Container(
                  width: Dimensions.widthRatio(context, 85),
                  padding: EdgeInsets.all(Dimensions.padding20(context)),
                  decoration: BoxDecoration(
                    color: Color(0xff023e8a),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x89000000),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.word.engWord?.phonetic ?? "",
                        style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 20)),
                      ),
                      SizedBox(height: Dimensions.height10(context)),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 4,
                        endIndent: Dimensions.widthRatio(context, 65),
                      ),
                      SizedBox(height: Dimensions.height10(context)),
                      Text(
                        widget.word.userDefinition ?? "",
                        style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 20)),
                      ),
                      SizedBox(height: Dimensions.height(context, 35)),
                      Text(
                        "Example:",
                        style: TextStyle(
                          fontSize: Dimensions.fontSize(context, 20),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Dimensions.height(context, 5)),
                      Text(
                        widget.word.description ?? "",
                        style: TextStyle(
                          fontSize: Dimensions.fontSize(context, 20),
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
