import 'package:dio/dio.dart';

import 'api.request.dart';

Future<Response> getData(params){
  print(params);

  return ajax.request(
      '/',
      options: Options(method: 'get'),
      queryParameters: params,
  );
}