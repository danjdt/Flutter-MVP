import 'package:flutter_mvp/data/character.dart';
import 'package:flutter_mvp/data/remote/list_character_request.dart';
import 'package:flutter_mvp/data/remote/marvel_api.dart';

abstract class CharacterListViewContract {
  void displayCharacters(List<Character> items);

  void displayError();
}

class CharacterListPresenter {

  CharacterListViewContract _view;
  MarvelApi _api;

  CharacterListPresenter(this._view) {
    _api = new MarvelApi();
  }

  void loadCharacterList(String characterName) {
    assert(_view != null);

    ListCharacterRequest request = new ListCharacterRequest();
    request.setLimit(25);
    request.setName(characterName);

    _api.fetchCharacters(request)
        .then((characters) => _view.displayCharacters(characters))
        .catchError((onError) {
      print(onError);
      _view.displayError();
    });
  }
}
