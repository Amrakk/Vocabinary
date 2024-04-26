import 'package:flutter/material.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/widgets/explore/inside_topic/item_vocab.dart';
import 'package:vocabinary/widgets/learnings/background_container.dart';
import 'package:vocabinary/widgets/learnings/confirm_button.dart';

class InsideTopicView extends StatefulWidget {
  const InsideTopicView({super.key});

  @override
  State<InsideTopicView> createState() => _InsideTopicViewState();
}

class _InsideTopicViewState extends State<InsideTopicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Snack and desserts in Britain',
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
                  height: Dimensions.heightRatio(context, 10),
                  width: double.infinity,
                ),
                BackgroundContainer(
                  heightRatio: 5,
                  widthRatio: 70,
                  borderRadius: 10,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Total words was added: 12',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: Dimensions.fontSize16(context),
                      ),
                    ),
                  ),
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
                          onPressed: () {
                            // TODO: Add new word
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
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // TODO: Navigate to card details
                      },
                      child: const ItemVocab(),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: Dimensions.heightRatio(context, 1.75)),
                    itemCount: 10,
                  ),
                ),
                SizedBox(height: Dimensions.heightRatio(context, 3)),
                ConfirmButton(
                  widthRatio: 100,
                  label: 'Play',
                  iconSize: Dimensions.iconSize(context, 36),
                  fontSize: Dimensions.fontSize20(context),
                  leftIcon: Icons.play_circle_outline_outlined,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
