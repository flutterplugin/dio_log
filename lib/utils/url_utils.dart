String getRealUrl(String url, Map<String, dynamic> params) {
  ///拼接实际请求链接
  StringBuffer str = StringBuffer(url);
  if (params?.length ?? 0 > 0) {
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
