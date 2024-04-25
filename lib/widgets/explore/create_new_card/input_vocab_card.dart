import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../../utils/dimensions.dart';

class InputVocabCard extends StatefulWidget {
  const InputVocabCard({super.key});

  // var _textNameController = TextEditingController();

  @override
  State<InputVocabCard> createState() => _InputVocabCardState();
}

class _InputVocabCardState extends State<InputVocabCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ShowInputDialog(context);
      },
      child: Container(
          height: Dimensions.heightRatio(context, 30),
          width: Dimensions.widthRatio(context, 60),
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: Text(
                textAlign: TextAlign.center,
            "Click here to start!",
            style: TextStyle(
              fontSize: Dimensions.fontSize(context, 22),
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ))),
    );
    // child:  TextField(
    //   textAlign: TextAlign.center,
    //   cursorColor: Colors.black,
    //   style: TextStyle(
    //     fontSize: Dimensions.fontSize(context, 30),
    //     fontWeight: FontWeight.w500,
    //     color: Colors.black,
    //   ),
    //   decoration: InputDecoration(
    //     border: InputBorder.none,
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.transparent,),
    //       borderRadius: BorderRadius.circular(25),
    //     ),
    //     enabledBorder:  OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.transparent),
    //       borderRadius: BorderRadius.circular(25),
    //     ),
    //     fillColor: const Color(0xFFE5E5E5),
    //   ),
    // ),
  }
}

void ShowInputDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = -50.0;
      const double end = 0.0;
      final Tween<double> tween = Tween(begin: begin, end: end);
      final double offset = tween.evaluate(animation);
      return Transform.translate(
        offset: Offset(0, offset),
        child: Opacity(
          opacity: animation.value,
          child:  SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            title: const Text('Vocabulary Info', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            titlePadding: const EdgeInsets.only(top: 20, left: 15, right: 20, bottom: 15),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(width: Dimensions.widthRatio(context, 70),),
                    const Text("Name", style: TextStyle(fontWeight: FontWeight.w500),),
                    const SizedBox(height: 10),
                    TextField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        fillColor: Colors.transparent
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text("Definition", style: TextStyle(fontWeight: FontWeight.w500),),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: null,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          fillColor: Colors.transparent
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: Colors.grey)
                            ),
                          ),
                            child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0645BB),
                          ),
                          onPressed: (){
                            // Todo save button
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

