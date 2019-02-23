import 'package:flutter/material.dart';
import 'package:flutter_mvp/module/list/character_list_view.dart';

void main() {
  runApp(
      new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
              primarySwatch: Colors.indigo
          ),
          home: new CharacterListPage()
      )
  );
}
