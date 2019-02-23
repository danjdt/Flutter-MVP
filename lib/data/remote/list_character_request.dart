import 'package:flutter_mvp/data/remote/base_request.dart';

class ListCharacterRequest extends GetRequest {

  String params = "";

  @override
  String getEndPoint() {
    return "characters";
  }

  @override
  String getParams() {
    return params;
  }

  void iterateMapEntry(key, value) {
    params += '$key=$value&';//string interpolation in action
  }

  setLimit(int limit) {
    setParam("limit", "${limit <= 100 ? limit : 100}");
  }

  setParam(String key, String value) {
    if(params.isNotEmpty) {
      params += "&";
    }

    params += "$key=$value";
  }
}