class EngWordModel {
  String? id;
  String? word;
  String? phonetic;
  String? audio;

  EngWordModel({
    this.id,
    this.word,
    this.phonetic,
    this.audio,
  });

  factory EngWordModel.fromMap(Map<String, dynamic> map, String id) {
    return EngWordModel(
      id: id,
      word: map['word'],
      phonetic: map['phonetic'],
      audio: map['audio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'phonetic': phonetic,
      'audio': audio,
    };
  }

  @override
  String toString() {
    return 'EngWordModel{id: $id, word: $word, phonetic: $phonetic, audio: $audio}';
  }

  void clearApiData() {
    word = null;
    phonetic = null;
    audio = null;
  }
}
