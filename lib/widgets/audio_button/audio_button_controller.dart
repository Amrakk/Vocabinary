import 'package:vocabinary/widgets/audio_button/audio_button.dart';

class AudioButtonController {
  AudioButtonState? state;

  Future<void> playAudio() async => state!.playAudio();
}
