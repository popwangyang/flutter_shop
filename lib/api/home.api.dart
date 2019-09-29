import 'package:dio/dio.dart';

import 'api.request.dart';

Future<Response> getData(params){
  print(params);

  return ajax.request({
    'options': Options(
      method: 'GET',
    ),
    'data': params,
    'path': '/copyright/ktv/ktv',
  });
}