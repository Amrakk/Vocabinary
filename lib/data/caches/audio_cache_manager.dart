import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheManager {
  static final _audioSources = <Map<LockCachingAudioSource, int>>[];
  static final _maxAudioCaches =
      int.tryParse(dotenv.get('MAX_AUDIO_SOURCES')) ?? 20;

  AudioCacheManager._();
  static final instance = AudioCacheManager._();

  static Future<LockCachingAudioSource> getAudioSource(String url) async {
    var audioSourceIndex = _getAudioSourceIndex(url);
    if (audioSourceIndex > -1) {
      final audioSourceMap = _audioSources.elementAt(audioSourceIndex);
      audioSourceMap.update(audioSourceMap.keys.first, (value) => value++);
      return audioSourceMap.keys.first;
    }

    if (_audioSources.length >= _maxAudioCaches) {
      var single = _getSingleAudioSource();
      if (single != null) await removeAudioSource(single.uri.toString());
    }

    final audioSource = LockCachingAudioSource(Uri.parse(url));
    _audioSources.add({audioSource: 1});
    return audioSource;
  }

  static Future<void> removeAudioSource(String url) async {
    final index = _getAudioSourceIndex(url);
    final audioSourceMap = _audioSources.elementAt(index);
    audioSourceMap.update(audioSourceMap.keys.first, (value) => value--);

    if (audioSourceMap.values.first == 0) {
      await audioSourceMap.keys.first.clearCache();
      _audioSources.removeAt(index);
    }
  }

  static int _getAudioSourceIndex(String url) {
    try {
      var audioSource = _audioSources
          .firstWhere((element) => element.keys.first.uri.toString() == url);
      return _audioSources.indexOf(audioSource);
    } catch (e) {
      return -1;
    }
  }

  static void stat() {
    print('========================');
    _audioSources.toList().forEach((element) {
      print(element.keys.first.uri.toString());
      print(element.values.first);
    });
    print('========================');
  }

  static LockCachingAudioSource? _getSingleAudioSource() {
    try {
      return _audioSources
          .firstWhere((element) => element.values.first == 1)
          .keys
          .first;
    } catch (e) {
      return null;
    }
  }

  static Future<void> dispose() async {
    try {
      for (final audioSource in _audioSources) {
        await audioSource.keys.first.clearCache().catchError((_) {});
      }
    } catch (e) {}
    _audioSources.clear();
  }
}
