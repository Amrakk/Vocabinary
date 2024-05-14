import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/eng_word.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vocabinary/widgets/level_star_bar.dart';

import '../../../models/data/word.dart';

class ItemVocab extends StatefulWidget {
  final EngWordModel engWord;
  final WordModel word;
   bool? isEditable= true;

   ItemVocab({
    super.key,
    this.isEditable,
    required this.engWord,
    required this.word,
  });

  @override
  State<ItemVocab> createState() => _ItemVocabState();
}

class _ItemVocabState extends State<ItemVocab> {
  @override
  Widget build(BuildContext context) {
    final AppColorsThemeData appColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: widget.isEditable!
            ? [
                SlidableAction(
                  onPressed: (ctx) {
                    // TODO: imeplement delete word
                  },
                  icon: Icons.delete,
                  backgroundColor: AppColors.mainRed,
                  foregroundColor: Colors.white,
                ),
                SlidableAction(
                  onPressed: (ctx) {
                    // TODO: imeplement edit word
                  },
                  icon: Icons.edit,
                  backgroundColor: levelToColor(widget.word.level),
                  foregroundColor: Colors.white,
                ),
              ]
            : [],
      ),
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
                        widget.engWord.word!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimensions.fontSize22(context),
                        ),
                      ),
                      SizedBox(height: Dimensions.heightRatio(context, 1)),
                      Text(
                        widget.engWord.phonetic!,
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
                          // TODO: Favorite button
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
