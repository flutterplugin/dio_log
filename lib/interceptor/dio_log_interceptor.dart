import 'package:dio/dio.dart';
import 'package:dio_log/bean/err_options.dart';
import 'package:dio_log/bean/req_options.dart';
import 'package:dio_log/bean/res_options.dart';

import '../dio_log.dart';

///log日志的处理类
class DioLogInterceptor implements Interceptor {
  LogPoolManager logManage;
  DioLogInterceptor() {
    logManage = LogPoolManager.getInstance();
  }

  @override
  Future onError(DioError err) async {
    var errOptions = ErrOptions();
    errOptions.id = err.request.hashCode;
    errOptions.errorMsg = err.toString();
    onResponse(err.response);
    logManage.onError(errOptions);
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    var reqOpt = ReqOptions();
    reqOpt.id = options.hashCode;
    reqOpt.url = options.uri.toString();
    reqOpt.method = options.method;
    reqOpt.contentType = options.contentType.toString();
    reqOpt.requestTime = DateTime.now();
    reqOpt.params = options.queryParameters;
    reqOpt.data = options.data;
    reqOpt.headers = options.headers;
    logManage.onRequest(reqOpt);
    return options;
  }

  @override
  Future onResponse(Response response) async {
    if (response != null) {
      var resOpt = ResOptions();
      resOpt.id = response.request?.hashCode;
      resOpt.responseTime = DateTime.now();
      resOpt.statusCode = response.statusCode ?? 0;
      resOpt.data = response.data;
      logManage.onResponse(resOpt);
    }
    return response;
  }
}
