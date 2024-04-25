import 'package:vocabinary/widgets/learnings/background_container.dart';

class BackgroundContainerController {
  BackgroundContainerState? state;

  void updateSize({double? widthRatio, double? heightRatio}) =>
      state?.updateSize(widthRatio: widthRatio, heightRatio: heightRatio);
}
