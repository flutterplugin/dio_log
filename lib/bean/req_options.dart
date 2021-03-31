///需要的请求数据类
class ReqOptions {
  int? id;
  String? url;
  String? method;
  String? contentType;
  DateTime? requestTime;
  Map<String, dynamic>? params;
  dynamic data;
  Map<String, dynamic>? headers;
  ReqOptions({
    this.id,
    this.url,
    this.method,
    this.contentType,
    this.requestTime,
    this.headers,
    this.params,
    this.data,
  });
}
