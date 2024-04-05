import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class CardVocabulary extends StatefulWidget {
  const CardVocabulary({super.key});

  @override
  State<CardVocabulary> createState() => _CardVocabularyState();
}

class _CardVocabularyState extends State<CardVocabulary> {
  var _isPlayingSound = false;
  var _isExpendable = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: Dimensions.widthSize(context, 85),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "rendezvous",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "English Dictionary",
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isPlayingSound = !_isPlayingSound;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _isPlayingSound
                        ? const Icon(
                      Icons.volume_up,
                    )
                        : const Icon(
                      Icons.volume_mute,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                const SizedBox(
                  width: 7,
                ),
                const Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.greenAccent,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
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
            const SizedBox(
              height: 15,
            ),
            // Expendable Text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: child,
                );
              },
              child: _isExpendable ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ren·dez·vous (/ˈrɑːn.deɪ.vuː/)",
                    style: TextStyle(fontSize: 15),
                  ),
                  const Text(
                    "noun [C]",
                    style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 4,
                    endIndent: Dimensions.widthSize(context, 65),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "an arrangement to meet someone, especially one made secretly by lovers",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    "Example:",
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "We have a rendezvous with destiny.",
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ],
              ) : null,
            )
          ],
        ),
      ),
    );
  }
}