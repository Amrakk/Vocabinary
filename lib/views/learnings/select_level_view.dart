import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/background_layer.dart';
import 'package:vocabinary/widgets/learnings/option_button.dart';
import 'package:vocabinary/models/arguments/learnings/select_words_args.dart';

class SelectLevelView extends StatelessWidget {
  const SelectLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SelectWordsArgs;
    final isEasy = args.words.any((element) => element.level == 1);
    final isMedium = args.words.any((element) => element.level == 2);
    final isHard = args.words.any((element) => element.level == 3);

    final isMix = (isEasy ? 1 : 0) + (isMedium ? 1 : 0) + (isHard ? 1 : 0) > 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                  child: Image.asset('assets/images/stepping_up.png'),
                ),
                SizedBox(
                  width: Dimensions.widthRatio(context, 55),
                  child: Text(
                    'What difficulty of cards do you want to focus on?',
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
                      _buildOptionButton(context, 'Easy', !isEasy, () {
                        _navigateToType(context, args, 1);
                      }),
                      SizedBox(height: Dimensions.height30(context)),
                      _buildOptionButton(context, 'Medium', !isMedium, () {
                        _navigateToType(context, args, 2);
                      }),
                      SizedBox(height: Dimensions.height30(context)),
                      _buildOptionButton(context, 'Hard', !isHard, () {
                        _navigateToType(context, args, 3);
                      }),
                      SizedBox(height: Dimensions.height30(context)),
                      _buildOptionButton(context, 'Mix it up!', !isMix, () {
                        _navigateToType(context, args, 0);
                      }),
                      SizedBox(height: Dimensions.height30(context)),
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

  Widget _buildOptionButton(
    BuildContext context,
    String label,
    bool disabled,
    VoidCallback onPressed,
  ) {
    return OptionButton(
      label: label,
      disabled: disabled,
      onPressed: onPressed,
    );
  }

  void _navigateToType(BuildContext context, SelectWordsArgs args, int level) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      '/type',
      arguments: SelectWordsArgs(
        words: _getWords(level, args.words),
      ),
    );
  }

  List<WordModel> _getWords(int level, List<WordModel> words) {
    return level == 0
        ? words
        : words.where((element) => element.level == level).toList();
  }
}
