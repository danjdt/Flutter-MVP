import 'dart:convert';

import 'package:flutter_mvp/data/character.dart';
import 'package:flutter_mvp/data/remote/list_character_request.dart';
import 'package:flutter_mvp/utils/cryto_utils.dart';
import 'package:http/http.dart' as http;

class MarvelApi {

  final String _baseUrl = 'https://gateway.marvel.com:443/v1/public/';

  final String publicKey = "82d370c41971065c5382d04b7569a384";
  final String privateKey = "bf3e7256ccc64c1d422c459bb36bd3b4d34bd5a3";

  final JsonDecoder _decoder = JsonDecoder();

  int ts = new DateTime.now().millisecondsSinceEpoch;

  Future<List<Character>> fetchCharacters(ListCharacterRequest request) async {
    ts = new DateTime.now().millisecondsSinceEpoch;
    print(_baseUrl + request.getEndPoint() + "?${request.getParams()}&ts=$ts&apikey=$publicKey&hash=${hash()}");
    final response =  await http.get(_baseUrl + request.getEndPoint() + "?${request.getParams()}&ts=$ts&apikey=$publicKey&hash=${hash()}");
    final items = get(response);
    return items.map((raw) => Character.fromMap(raw)).toList();
  }

  List get(http.Response response) {
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    print(jsonBody.toString());

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }

    final container = _decoder.convert(jsonBody);
    return container["data"]["results"];
  }

  hash() {
    return CryptoUtils.generateMd5("$ts$privateKey$publicKey");
  }
}