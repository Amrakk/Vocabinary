class Phonetic {
  String? text;
  String? audio;

  Phonetic({this.text, this.audio});

  factory Phonetic.fromMap(Map<String, dynamic> map) {
    return Phonetic(text: map['text'] ?? '', audio: map['audio'] ?? '');
  }
}

class DictResponse {
  String word;
  String? phonetic;
  List<Phonetic> phonetics;

  DictResponse({
    required this.word,
    this.phonetic,
    this.phonetics = const [],
  });

  factory DictResponse.fromMap(Map<String, dynamic> map) {
    return DictResponse(
      word: map['word'],
      phonetic: map['phonetic'] ?? '',
      phonetics: List<Phonetic>.from(map['phonetics'] ?? []),
    );
  }
}
