import 'package:dio/dio.dart';
import 'package:dio_log/utils/log_pool_manage.dart';

///log日志的处理类
class HttpLogInterceptor implements InterceptorsWrapper {
  ///是否启用网络log日志
  bool useLogRecord;
  LogPoolManage logManage;
  static final String reqTimeKey = "logRequestTime";
  static final String resTimeKey = "logResponseTime";
  HttpLogInterceptor() {
    logManage = LogPoolManage.getInstance();
  }

  @override
  onError(DioError err) {
    logManage.onError(err);
    return err;
  }

  @override
  onRequest(RequestOptions options) {
    ///记录请求时间
    options.queryParameters
        .putIfAbsent(reqTimeKey, () => DateTime.now().millisecondsSinceEpoch);
    logManage.onRequest(options);
    return options;
  }

  @override
  onResponse(Response response) {
    ///记录返回时间
    response.request.queryParameters
        .putIfAbsent(resTimeKey, () => DateTime.now().millisecondsSinceEpoch);
    logManage.onResponse(response);
    return response;
  }
}
