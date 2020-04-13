import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  var _cache = new Map<Uri, Response>();

  @override
  onRequest(RequestOptions options) async {
    if(_cache[options.uri]!=null)
    {
      print("from cache"+options.uri.toString());
      return _cache[options.uri];
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    //print("from http request"+response.request.uri.toString());
    if(response.statusCode!=403)
    _cache[response.request.uri] = response;  
  }

  @override
  onError(DioError e) async{
    print('onError: $e');
    if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.DEFAULT) {
      var cachedResponse = _cache[e.request.uri];
      if (cachedResponse != null) {
        return cachedResponse;
      }
      else
      {
        return Future.error("Please check your network connection..");

      }
    }
    return e;
  }
}