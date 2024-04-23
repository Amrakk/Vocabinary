import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/dimensions.dart';
import '../../global/level_bar_star.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          onPressed: (ctx) {},
          icon: Icons.delete,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        SlidableAction(
          onPressed: (ctx) {},
          icon: Icons.edit,
          backgroundColor: const Color(0xFFEDC531),
          foregroundColor: Colors.white,
        ),
      ]),
      child: Stack(children: [
        Container(
          height: Dimensions.heightRatio(context, 15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
            color: appColors.containerColor,
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black26,
            //     blurRadius: 4,
            //     spreadRadius: 3,
            //   ),
            // ],
          ),
          child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.padding(context, 40),
                  right: Dimensions.padding30(context),
                  top: Dimensions.padding20(context),
                  bottom: Dimensions.padding20(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Economic",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.fontSize(context, 28))),
                      SizedBox(height: Dimensions.height10(context)),
                      Text("/ēkəˈnämik/",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.fontSize(context, 20))),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Todo: Favorite button
                        },
                        icon: Icon(Icons.favorite,
                            color: const Color(0xFFEDC531),
                            size: Dimensions.iconSize(context, 39)),
                      ),
                      LevelStarBar(level: 3),
                    ],
                  )
                ],
              )),
        ),
        Container(
          height: Dimensions.heightRatio(context, 15),
          width: Dimensions.width12(context),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(2),
            //   topLeft: Radius.circular(2),
            // ),
            color: Color(0xFFEDC531),
          ),
        )
      ]),
    );
  }
}
