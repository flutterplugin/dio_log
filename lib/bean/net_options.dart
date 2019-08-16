import 'err_options.dart';
import 'req_options.dart';
import 'res_options.dart';

class NetOptions {
  ReqOptions reqOptions;
  ResOptions resOptions;
  ErrOptions errOptions;
  NetOptions({
    this.reqOptions,
    this.resOptions,
    this.errOptions,
  });
}
