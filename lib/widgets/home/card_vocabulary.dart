import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/audio_button/audio_button.dart';

class CardVocabulary extends StatefulWidget {
  final WordModel word;
  const CardVocabulary({super.key, required this.word});

  @override
  State<CardVocabulary> createState() => _CardVocabularyState();
}

class _CardVocabularyState extends State<CardVocabulary> {
  var _isExpendable = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: Dimensions.widthRatio(context, 85),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.padding20(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.word.engWord?.word ?? "",
                      style: TextStyle(
                          fontSize: Dimensions.fontSize30(context),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "English Definition",
                      style: TextStyle(
                          fontSize: Dimensions.fontSize(context, 13),
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                AudioButton(
                  word: widget.word.engWord?.word ?? "",
                  url:
                      widget.word.engWord?.audio ?? "",
                ),
              ],
            ),
            SizedBox(height: Dimensions.height10(context)),
            InkWell(
              onTap: () {
                setState(() {
                  _isExpendable = !_isExpendable;
                });
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: Dimensions.width(context, 7)),
                  Text(
                    "Details",
                    style: TextStyle(
                      fontSize: Dimensions.fontSize(context, 15),
                      color: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(width: Dimensions.width(context, 7)),
                  _isExpendable
                      ? Icon(
                          Icons.keyboard_arrow_up,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height(context, 15)),
            // Expendable Text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: child,
                );
              },
              child: _isExpendable
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.word.engWord?.phonetic ?? "",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize(context, 15)),
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
                              fontSize: Dimensions.fontSize(context, 15)),
                        ),
                        SizedBox(height: Dimensions.height(context, 35)),
                        Text(
                          "Example:",
                          style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 15),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.height(context, 5)),
                        Text(
                          widget.word.description ?? "",
                          style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 15),
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
