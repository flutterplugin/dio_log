import 'err_options.dart';
import 'req_options.dart';
import 'res_options.dart';

class NetWork {
  final ReqOptions reqOptions;
  final ResOptions resOptions;
  final ErrOptions errOptions;
  NetWork({
    this.reqOptions,
    this.resOptions,
    this.errOptions,
  });
}
