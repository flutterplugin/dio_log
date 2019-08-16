import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';

Dio dio = Dio();

initHttp() {
  dio.interceptors.add(DioLogInterceptor());
}

httpGet(String url) {
  dio.get(url);
}
