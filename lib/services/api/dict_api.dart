import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vocabinary/models/data/eng_word.dart';

class DictApi {
  static const String _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  Future<EngWordModel> getApiData(String word) async {
    final response = await http.get(Uri.parse('$_baseUrl$word'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> data = jsonDecode(response.body);
      var word = data[0]['word'];
      if(data[0]['phonetics'].length > 2){
        return EngWordModel(word: word, phonetic: data[0]['phonetics'][1]['text'], audio: data[0]['phonetics'][1]['audio']);
      }
      return EngWordModel(word: word, phonetic: data[0]['phonetics'][0]['text'], audio: data[0]['phonetics'][0]['audio']);

    } else {
      // If the server did not return a 200 OK response, throw an exception.
      return EngWordModel(word: word, phonetic: '', audio: '');
    }
  }
}