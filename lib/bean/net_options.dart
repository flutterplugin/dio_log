import 'err_options.dart';
import 'req_options.dart';
import 'res_options.dart';

///需要的网络数据类
class NetOptions {
  ReqOptions? reqOptions;
  ResOptions? resOptions;
  ErrOptions? errOptions;
  NetOptions({
    this.reqOptions,
    this.resOptions,
    this.errOptions,
  });
}

///判断返回数据是否异常
typedef ResError = bool Function(NetOptions res);
