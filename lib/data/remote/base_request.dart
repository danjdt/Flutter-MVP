abstract class BaseRequest {

  String getEndPoint();
}

abstract class GetRequest extends BaseRequest {

  String getParams();

  setParam(String key, String value);
}

abstract class PostRequest extends BaseRequest {

  Map<String, Object> getBody();
}