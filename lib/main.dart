import 'package:flutter/material.dart';
import 'package:flutter_mvp/ui/list/character_list_view.dart';

void main() {
  runApp(
      new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
              primarySwatch: Colors.red
          ),
          home: new CharacterList()
      )
  );
}
