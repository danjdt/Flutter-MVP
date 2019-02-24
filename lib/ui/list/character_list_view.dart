import 'package:flutter/material.dart';
import 'package:flutter_mvp/data/character.dart';
import 'package:flutter_mvp/ui/list/character_list_presenter.dart';

class CharacterList extends StatefulWidget {
  CharacterList({Key key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>
    implements CharacterListViewContract {
  final key = new GlobalKey<ScaffoldState>();

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  Widget appBarTitle = new Text(
    "Marvel Character List",
    style: new TextStyle(color: Colors.white),
  );

  final TextEditingController _searchQuery = new TextEditingController();

  CharacterListPresenter _presenter;

  List<Character> _characters = List();

  bool _isLoading;

  _CharacterListState() {
    _presenter = CharacterListPresenter(this);
    _setListeners();
  }

  _setListeners() {
    _searchQuery.addListener(() {
      String searchText = _searchQuery.text;
      setState(() {
        _isLoading = true;
      });

      _presenter.loadCharacterList(searchText);
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCharacterList(null);
  }

  @override
  void onLoadComplete(List<Character> items) {
    setState(() {
      if (items != null) {
        _characters.clear();
        _characters.addAll(items);
        _isLoading = false;
      }
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
    return new Scaffold(
        key: key, appBar: _buildAppBar(context), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    var widget;
    if (_isLoading) {
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

  Widget _buildAppBar(BuildContext context) {
    return new AppBar(
        leading: const BackButton(),
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintStyle:
                            new TextStyle(fontSize: 20, color: Colors.white)),
                  );
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  CharacterListItem _buildCharacterItem(int index) {
    return new CharacterListItem(character: _characters[index], onTap: () {});
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Marvel Character List",
        style: new TextStyle(color: Colors.white),
      );
      _searchQuery.clear();
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
