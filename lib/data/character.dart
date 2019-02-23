import 'package:flutter_mvp/data/thumbnail.dart';

class Character {

  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;

  const Character({this.id, this.name, this.description, this.thumbnail});

  Character.fromMap(Map<String, dynamic> map):
        id = map['id'],
        name = "${map['name']}",
        description = "${map['description']}",
        thumbnail = Thumbnail.fromMap(map["thumbnail"]);

  @override
  fromMap(Map<String, dynamic> map) {
    return Character.fromMap(map);
  }
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
