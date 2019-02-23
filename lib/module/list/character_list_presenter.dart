import 'package:flutter_mvp/data/character.dart';
import 'package:flutter_mvp/data/remote/list_character_request.dart';
import 'package:flutter_mvp/data/remote/marvel_api.dart';

abstract class CharacterListViewContract {
  void onLoadComplete(List<Character> items);

  void onLoadError();
}

class CharacterListPresenter {
  CharacterListViewContract _view;
  MarvelApi _api;

  CharacterListPresenter(this._view) {
    _api = new MarvelApi();
  }

  void loadCharacterList() {
    assert(_view != null);

    ListCharacterRequest request = new ListCharacterRequest();
    request.setLimit(100);

    _api.fetchCharacters(request)
        .then((contacts) => _view.onLoadComplete(contacts))
        .catchError((onError) {
      print(onError);
      _view.onLoadError();
    });
  }
}
