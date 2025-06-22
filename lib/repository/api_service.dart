import 'package:bucket_list_flutter/repository/token_interceptor.dart';
import 'package:bucket_list_flutter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiService {
  final Dio _dio = Dio();

  ApiService._internal() {
    _dio.interceptors.add(PrettyDioLogger());
  }

  static final ApiService _instance = ApiService._internal();

  void _updateBaseUrl() {
    _dio.options.baseUrl = BASEURL;
  }

  void _addTokenInterceptor({String? params}) {
    _dio.interceptors.removeWhere((interceptor) => interceptor is TokenInterceptor);
    _dio.interceptors.add(TokenInterceptor(token: params));
  }

  factory ApiService({String? token}) {
    _instance._updateBaseUrl();
    _instance._addTokenInterceptor(params: token);
    return _instance;
  }

  Dio get sendRequest => _dio;
}

/*
class ApiService {
  final Dio _dio = Dio();

  ApiService._internal() {
    _dio.options.baseUrl = BASEURL;
    _dio.interceptors.add(PrettyDioLogger());
  }

  static final ApiService _instance = ApiService._internal();

  _addTokenInterceptor({String? params}) {
    if (_dio.interceptors.isEmpty) {
      _dio.interceptors.add(TokenInterceptor(token: params));
    }
    else {
      _dio.interceptors.removeWhere((interceptor) => interceptor is TokenInterceptor);
      _dio.interceptors.add(TokenInterceptor(token: params));
    }
  }

  factory ApiService({String? token}) {
    _instance._addTokenInterceptor(params: token);
    return _instance;
  }

  Dio get sendRequest => _dio;
}*/
