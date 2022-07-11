import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';

Dio dio = Dio();

initHttp() {
  DioLogInterceptor.enablePrintLog = false;
  dio.interceptors.add(DioLogInterceptor());
  // LogPoolManager.getInstance().isError = (res) => res.resOptions==null;
}

httpGet(String url) {
  dio.get(url);
}
