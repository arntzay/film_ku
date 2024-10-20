import 'package:dio/dio.dart';
import 'package:film_ku/data/api/error_handle.dart';
import 'package:film_ku/data/api/http_config.dart';

class Api {
  final dioInstance = createDio();

  static final Api _singleton = Api._internal();

  factory Api() {
    return _singleton;
  }

  Api._internal();

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: HttpConfig.baseUrl,
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    dio.options.contentType = Headers.jsonContentType;

    dio.interceptors.addAll({
      ErrorHandle(dio),
    });
    return dio;
  }
}
