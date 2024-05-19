import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vocabinary/widgets/level_star_bar.dart';

import '../../../models/arguments/explore/update_card_args.dart';
import '../../../models/data/word.dart';
import '../../../viewmodels/explore/word_view_model.dart';

class ItemVocab extends StatefulWidget {
  final EngWordModel engWord;
  final WordModel word;
  bool? isEditable = true;
  final String topicID;

  ItemVocab({
    super.key,
    this.isEditable,
    required this.topicID,
    required this.engWord,
    required this.word,
  });

  @override
  State<ItemVocab> createState() => _ItemVocabState();
}

class _ItemVocabState extends State<ItemVocab> {
  late WordViewModel _wordViewModel;

  @override
  void initState() {
    _wordViewModel = WordViewModel(widget.topicID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppColorsThemeData appColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Slidable(
      startActionPane: widget.isEditable ?? true
          ? ActionPane(motion: const DrawerMotion(), children: [
              SlidableAction(
                onPressed: (ctx) {
                  //confirm dialog
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Delete Word'),
                          content: const Text(
                              'Are you sure you want to delete this word?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await _wordViewModel
                                    .deleteWord(widget.word.id!);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      });
                },
                icon: Icons.delete,
                backgroundColor: AppColors.mainRed,
                foregroundColor: Colors.white,
              ),
              SlidableAction(
                onPressed: (ctx) {
                  //navigate to edit word
                  Navigator.of(context).pushNamed(
                    '/update-card',
                    arguments: UpdateCardArgs(
                      topicID: widget.topicID,
                      word: widget.word,
                    ),
                  );
                },
                icon: Icons.edit,
                backgroundColor: AppColors.mainYellow,
                foregroundColor: Colors.white,
              ),
            ])
          : null,
      child: Stack(
        children: [
          Container(
            height: Dimensions.heightRatio(context, 12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: appColors.containerColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.widthRatio(context, 8.5),
                right: Dimensions.widthRatio(context, 6),
                top: Dimensions.heightRatio(context, 0.75),
                bottom: Dimensions.heightRatio(context, 0.75),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.engWord.word ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimensions.fontSize22(context),
                        ),
                      ),
                      SizedBox(height: Dimensions.heightRatio(context, 1)),
                      Text(
                        widget.engWord.phonetic ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.fontSize18(context),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            widget.word.isFavorite = !widget.word.isFavorite;
                            _wordViewModel.updateWord(widget.word);
                          });
                        },
                        icon: Icon(
                          widget.word.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: levelToColor(widget.word.level),
                          size: Dimensions.widthRatio(context, 7.25),
                        ),
                      ),
                      LevelStarBar(
                        level: widget.word.level,
                        size: Dimensions.widthRatio(context, 6.75),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: Dimensions.heightRatio(context, 12),
            width: Dimensions.widthRatio(context, 1.25),
            decoration: BoxDecoration(
              color: levelToColor(widget.word.level),
            ),
          )
        ],
      ),
    );
  }

  Color levelToColor(int level) {
    if (level == 1) {
      return AppColors.mainGreen;
    } else if (level == 2) {
      return AppColors.mainBlue;
    } else if (level == 3) {
      return AppColors.mainYellow;
    } else {
      return AppColors.mainGreen;
    }
  }
}
