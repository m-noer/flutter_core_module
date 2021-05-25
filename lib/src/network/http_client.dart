import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HttpClient {
  HttpClient();

  Dio get dio => _getDio();

  var logger = Logger();

  Dio _getDio() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://reqres.in/api/",
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = new Dio(options);
    dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      logger.i(
          "--> ${options.method.toUpperCase()} ${"" + (options.baseUrl) + (options.path)}");
      logger.i("Headers:");
      options.headers.forEach((k, v) => print('$k: $v'));

      logger.i("--> END ${options.method.toUpperCase()}");

      if (options.headers.containsKey('isToken')) {
        options.headers.remove('isToken');
        // options.headers.addAll({
        //   'Authorization':
        //       'Bearer ${registerToken != null ? registerToken : accessToken}'
        // });
      }
      // Do something before request is sent
      logger.i("\n"
          "-- headers --\n"
          "${options.headers.toString()} \n"
          "-- response --\n -->x"
          "${options.data} \n"
          "");

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (response, handler) {
      // Do something with response data
      logger.i("${JsonEncoder.withIndent('  ').convert(response.data)} \n");

      return handler.next(response); // continue
    }, onError: (DioError error, handler) {
      // Do something with response error
      return handler.next(error); //continue
    });
  }
}
