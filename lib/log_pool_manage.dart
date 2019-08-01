import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:dio_log/http_log_interceptor.dart';

///log管理
class LogPoolManage {
  ///请求日志存储
  LinkedHashMap<String, HttpLog> logMap;

  List<String> keys;

  ///存储请求最大数
  int maxCount = 30;
  static LogPoolManage instance;

  LogPoolManage._singleton() {
    logMap = LinkedHashMap();
    keys = List();
  }

  static LogPoolManage getInstance() {
    if (instance == null) {
      instance = LogPoolManage._singleton();
    }
    return instance;
  }

  void onError(DioError err) {
    var key = '${err.request.queryParameters[HttpLogInterceptor.reqTimeKey]}';
    if (logMap.containsKey(key)) {
      logMap.update(key, (value) {
        value.err = err;
        return value;
      });
    }
  }

  void onRequest(RequestOptions options) {
    if (logMap.length > maxCount) {
      logMap.remove(keys.last);
      keys.removeLast();
    }
    var key = '${options.queryParameters[HttpLogInterceptor.reqTimeKey]}';
    keys.insert(0, key);
    logMap.putIfAbsent(key, () => HttpLog(options: options));
  }

  void onResponse(Response response) {
    var key =
        '${response.request.queryParameters[HttpLogInterceptor.reqTimeKey]}';
    if (logMap.containsKey(key)) {
      logMap.update(key, (value) {
        value.response = response;
        return value;
      });
    }
  }

  void clear() {
    logMap.clear();
    keys.clear();
  }
}

///存放一个完整请求记录的类
class HttpLog {
  RequestOptions options;
  Response response;
  DioError err;

  HttpLog({this.options, this.response, this.err});
}
