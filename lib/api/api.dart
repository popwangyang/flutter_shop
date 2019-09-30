
import 'package:dio/dio.dart';

class HttpRequest {

  HttpRequest({this.baseUrl});

  final String baseUrl;

  BaseOptions getInsideConfig () {

    BaseOptions config = new BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: {
        'Content-Type': 'application/json;'
      }
    );

    return config;
  }

  InterceptorsWrapper _wrapper(){
    return InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['Authorization'] = 'Bearer ' +'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6IjEzMTQxNDYiLCJleHAiOjE1Njk4MzM2MTQsImVtYWlsIjoiYWRtaW5AaGxjaGFuZy5jbiIsIm9yaWdfaWF0IjoxNTY5NzQ3MjEzfQ.azF_RN2XhPjQ8mvFiu99j8F5-1qj7wBC1g61S37npm8';
      return options; //continue
    }, onResponse: (Response response) {
      print("响应之前");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      return e; //continue
    });
  }

  Future<Response> request (
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
      }) {
    Dio instance = new Dio(getInsideConfig());
    instance.interceptors.add(_wrapper());
    return instance.request(
        path,
        options: options,
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
    );
  }

}

