///拼接实际请求链接
String getRealUrl(String url, Map<String, dynamic> params) {
  StringBuffer str = StringBuffer(url);
  if (params.length as bool? ?? 0 > 0) {
    str.write('?');
    var hasAnd = false;
    params.forEach((key, value) {
      if (hasAnd) {
        hasAnd = true;
        str.write('&');
      }
      str.write('$key=$value');
    });
  }
  return str.toString();
}
