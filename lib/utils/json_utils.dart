import 'dart:convert';

toJson(dynamic data) {
  var je = JsonEncoder.withIndent('  ');
  var json = je.convert(data);
  return json;
}
