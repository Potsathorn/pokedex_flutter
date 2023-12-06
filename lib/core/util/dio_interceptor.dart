// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:pokedex_flutter/config/base_url.dart';

class DioInterceptor implements Interceptor {
  final BaseUrlConfig _baseUrlConfig;

  DioInterceptor(this._baseUrlConfig);
  @override
  void onRequest(options, handler) async {
    options.baseUrl = _baseUrlConfig.baseUrl;
    if (options.headers['content-type'] == null) {
      options.headers['content-type'] = 'application/json';
    }

    if (options.headers['accept'] == null) {
      options.headers['accept'] = 'application/json';
    }

    debugPrint('${options.method}|${options.path} | ${options.data}');

    handler.next(options);
  }

  @override
  Future<void> onError(err, handler) async {
    debugPrint('onError : ${err.response?.statusCode} | ${err.response?.data}');

    return handler.reject(err);
  }

  @override
  Future<void> onResponse(response, handler) async {
    debugPrint('onResponse : ${response.statusCode}  => ${response.data}');

    return handler.next(response);
  }
}
