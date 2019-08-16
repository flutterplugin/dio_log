class ReqOptions {
  final String url;
  final String method;
  final String statusCode;
  final String contentType;
  final DateTime requestTime;
  final String responseTime;
  final Duration duration;
  final String cookies;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final Map<String, dynamic> body;
  final Map<String, dynamic> extra;
  ReqOptions({
    this.url,
    this.method,
    this.statusCode,
    this.contentType,
    this.requestTime,
    this.responseTime,
    this.duration,
    this.cookies,
    this.headers,
    this.params,
    this.body,
    this.extra,
  });
}
