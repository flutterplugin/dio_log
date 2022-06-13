import 'package:dio/dio.dart';
import 'package:dio_log/bean/err_options.dart';
import 'package:dio_log/bean/net_options.dart';
import 'package:dio_log/bean/req_options.dart';
import 'package:dio_log/bean/res_options.dart';

import '../dio_log.dart';

///log日志的处理类
class DioLogInterceptor implements Interceptor {
  LogPoolManager? logManage;

  ///是否打印日志到控制台
  static bool enablePrintLog = true;

  DioLogInterceptor() {
    logManage = LogPoolManager.getInstance();
  }

  ///错误数据采集
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var errOptions = ErrOptions();
    errOptions.id = err.requestOptions.hashCode;
    errOptions.errorMsg = err.toString();
    //onResponse(err.response);
    logManage?.onError(errOptions);
    if (err.response != null) saveResponse(err.response!);
    return handler.next(err);
  }

  ///请求体数据采集
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var reqOpt = ReqOptions();
    reqOpt.id = options.hashCode;
    reqOpt.url = options.uri.toString();
    reqOpt.method = options.method;
    reqOpt.contentType = options.contentType.toString();
    reqOpt.requestTime = DateTime.now();
    reqOpt.params = options.queryParameters;
    reqOpt.data = options.data;
    reqOpt.headers = options.headers;
    logManage?.onRequest(reqOpt);
    return handler.next(options);
  }

  ///响应体数据采集
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    saveResponse(response);
    return handler.next(response);
  }

  void saveResponse(Response response) {
    var resOpt = ResOptions();
    resOpt.id = response.requestOptions.hashCode;
    resOpt.responseTime = DateTime.now();
    resOpt.statusCode = response.statusCode ?? 0;
    resOpt.data = response.data;
    resOpt.headers = response.headers.map;
    logManage?.onResponse(resOpt);
    if (enablePrintLog) {
      NetOptions log = LogPoolManager.getInstance().logMap[resOpt.id.toString()]!;
      print('dio_log: request: url:${log.reqOptions?.url}');
      print('dio_log: request: method:${log.reqOptions?.method}');
      print('dio_log: request: params:${log.reqOptions?.params}');
      print('dio_log: request: duration:${getTimeStr1(log.reqOptions!.requestTime!)}');
      print('dio_log: response: ${toJson(log.resOptions?.data)}');
    }
  }
}
