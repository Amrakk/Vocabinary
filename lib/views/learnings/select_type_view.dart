import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/widgets/learnings/option_button.dart';
import 'package:vocabinary/models/arguments/learnings/select_words_args.dart';

class SelectTypeView extends StatelessWidget {
  const SelectTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as SelectWordsArgs;
    final disableQuiz = args.words.length < 4;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Review',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const BackgroundLayer(ratio: 45),
          Center(
            child: Column(
              children: [
                SizedBox(height: Dimensions.height(context, 60)),
                SizedBox(
                  height: Dimensions.heightRatio(context, 25),
                  child: Image.asset('assets/images/thinking.png'),
                ),
                SizedBox(
                  width: Dimensions.widthRatio(context, 75),
                  child: Text(
                    'Which method of practice would you like to use for memorizing vocabulary?',
                    style: TextStyle(
                      fontSize: Dimensions.fontSize(context, 14),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Dimensions.height30(context)),
                Expanded(
                  child: Column(
                    children: [
                      OptionButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/flashcard',
                            arguments: args,
                          );
                        },
                        label: 'Flashcard',
                      ),
                      SizedBox(height: Dimensions.height30(context)),
                      OptionButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/quiz',
                            arguments: args,
                          );
                        },
                        label: 'Multiple-Choice',
                        disabled: disableQuiz,
                      ),
                      SizedBox(height: Dimensions.height30(context)),
                      OptionButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/typing',
                            arguments: args,
                          );
                        },
                        label: 'Fill in Word',
                      ),
                      SizedBox(height: Dimensions.height22(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
