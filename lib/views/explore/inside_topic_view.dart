
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/utils/dimensions.dart';

import '../../utils/app_themes.dart';
import '../../widgets/explore/inside_topic/Item_vocab.dart';

class InsideTopicView extends StatefulWidget {
  const InsideTopicView({super.key});

  @override
  State<InsideTopicView> createState() => _InsideTopicViewState();
}

class _InsideTopicViewState extends State<InsideTopicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.padding30(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height30(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Recent Cards',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.fontSize(context, 28))),
                    SizedBox(width: Dimensions.width20(context)),
                    FloatingActionButton.small(
                      onPressed: () {},
                      backgroundColor: const Color(0xFF023E8A),
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                Image.network(
                  "https://i.ibb.co/FD3Prty/man-business-coach.png",
                  height: Dimensions.heightRatio(context, 12),
                  width: Dimensions.widthRatio(context, 16),
                )
              ],
            ),
            SizedBox(
                height: Dimensions.heightRatio(context, 52),
                child: ListView.separated(
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // Todo: ItemVocab
                        },
                        child: const ItemVocab()),
                    separatorBuilder: (context, index) => SizedBox(
                          height: Dimensions.height30(context),
                        ),
                    itemCount: 10)),
            SizedBox(height: Dimensions.height30(context)),
            InkWell(
              onTap: () {
                // Todo: Play button
              },
              borderRadius: BorderRadius.circular(15),
              child: Ink(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFF023E8A),
                ),
                child: SizedBox(
                  height: Dimensions.heightRatio(context, 9),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Play',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.fontSize(context, 30))),
                      SizedBox(width: Dimensions.width(context, 8)),
                      Icon(Icons.play_circle_outline_outlined,
                          color: Colors.white,
                          size: Dimensions.iconSize(context, 50)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize myAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Stack(clipBehavior: Clip.none, children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
          child: AppBar(
            title: Text('Snack and desserts in Britain',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.fontSize(context, 32))),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF003566),
                    Color(0xFF006FD6),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -20,
          left: MediaQuery.of(context).size.width / 2 -
              Dimensions.widthRatio(context, 70) / 2,
          child: Container(
            height: 40,
            width: Dimensions.widthRatio(context, 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Center(
              child: Text('Total words was added: 12',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.fontSize(context, 28))),
            ),
          ),
        ),
      ]),
    );
  }
}
