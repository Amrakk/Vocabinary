import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/audio_button.dart';

class CardVocabulary extends StatefulWidget {
  const CardVocabulary({super.key});

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
                      "rendezvous",
                      style: TextStyle(
                          fontSize: Dimensions.fontSize30(context),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "English Dictionary",
                      style: TextStyle(
                          fontSize: Dimensions.fontSize(context, 13),
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                const AudioButton(
                  url:
                      'https://api.dictionaryapi.dev/media/pronunciations/en/rendezvous-us.mp3',
                ),
              ],
            ),
            SizedBox(height: Dimensions.height10(context)),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(width: Dimensions.width(context, 7)),
                Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: Dimensions.fontSize(context, 15),
                    color: Colors.greenAccent,
                  ),
                ),
                SizedBox(width: Dimensions.width(context, 7)),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpendable = !_isExpendable;
                    });
                  },
                  child: _isExpendable
                      ? Icon(
                          Icons.keyboard_arrow_up,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ),
              ],
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
                          "ren·dez·vous (/ˈrɑːn.deɪ.vuː/)",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize(context, 15)),
                        ),
                        Text(
                          "noun [C]",
                          style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 13),
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10(context)),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                          thickness: 4,
                          endIndent: Dimensions.widthRatio(context, 65),
                        ),
                        SizedBox(height: Dimensions.height10(context)),
                        Text(
                          "an arrangement to meet someone, especially one made secretly by lovers",
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
                          "We have a rendezvous with destiny.",
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
