import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vocabinary/widgets/level_star_bar.dart';

class ItemVocab extends StatefulWidget {
  const ItemVocab({super.key});

  @override
  State<ItemVocab> createState() => _ItemVocabState();
}

class _ItemVocabState extends State<ItemVocab> {
  @override
  Widget build(BuildContext context) {
    final AppColorsThemeData appColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Slidable(
      startActionPane: ActionPane(motion: const DrawerMotion(), children: [
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
          backgroundColor: AppColors.mainYellow,
          foregroundColor: Colors.white,
        ),
      ]),
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
                        "Economic",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimensions.fontSize22(context),
                        ),
                      ),
                      SizedBox(height: Dimensions.heightRatio(context, 1)),
                      Text(
                        "/ēkəˈnämik/",
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
                          Icons.favorite,
                          color: AppColors.mainYellow,
                          size: Dimensions.widthRatio(context, 7.25),
                        ),
                      ),
                      LevelStarBar(
                        level: 3,
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
            decoration: const BoxDecoration(
              color: AppColors.mainYellow,
            ),
          )
        ],
      ),
    );
  }
}
