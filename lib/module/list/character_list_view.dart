import 'package:flutter/material.dart';
import 'package:flutter_mvp/data/character.dart';
import 'package:flutter_mvp/module/list/character_list_presenter.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Marvel Character List"),
        ),
        body: CharacterList());
  }
}

class CharacterList extends StatefulWidget {
  CharacterList({Key key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>
    implements CharacterListViewContract {
  CharacterListPresenter _presenter;

  List<Character> _characters = List();

  bool _isLoading;

  _CharacterListState() {
    _presenter = CharacterListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCharacterList();
  }

  @override
  void onLoadComplete(List<Character> items) {
    setState(() {
      _characters.clear();
      _characters.addAll(items);
      _isLoading = false;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isLoading && _characters.isEmpty) {
      widget = Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
      widget = ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: (_characters.length * 2),
          itemBuilder: (context, index) {
            return ((index).isOdd)
                ? Divider()
                : _buildCharacterItem((index / 2).floor());
          });
    }

    return widget;
  }

  CharacterListItem _buildCharacterItem(int index) {
    return new CharacterListItem(
        character: _characters[index],
        onTap: () {
        });
  }
}

class CharacterListItem extends ListTile {
  CharacterListItem(
      {@required Character character, @required GestureTapCallback onTap})
      : super(
            title: Text(character.name),
            leading: CircleAvatar(
              child: new Container(
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "${character.thumbnail.path}/standard_medium.${character.thumbnail.extension}")))),
            ),
            onTap: onTap);
}
