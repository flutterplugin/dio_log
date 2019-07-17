import 'package:dio_log/log_pool_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponseLogWidget extends StatefulWidget {
  final HttpLog httpLog;

  ResponseLogWidget(this.httpLog);

  @override
  _ResponseLogWidgetState createState() => _ResponseLogWidgetState();
}

class _ResponseLogWidgetState extends State<ResponseLogWidget> {
  @override
  Widget build(BuildContext context) {
    var response = widget.httpLog.response;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            var snackBar = SnackBar(content: Text('copy success'));
            Scaffold.of(context).showSnackBar(snackBar);
            Clipboard.setData(ClipboardData(text: response?.data?.toString()));
          },
          child: Text('copy'),
        ),
        Container(
          margin: EdgeInsets.all(12.0),
          child: Text(_jsonFormat(response?.data?.toString())),
        ),
      ],
    ));
  }

  ///json显示格式化
  String _jsonFormat(String json) {
    if (json == null || json.isEmpty) {
      return '未收到服务端返回数据，请检查网络';
    }
    json = json.replaceAll(RegExp('{'), '{\n    ');
    json = json.replaceAll(RegExp('}'), '\n    }');
    json = json.replaceAll(RegExp('\\['), '[\n    ');
    json = json.replaceAll(RegExp('\\]'), '\n    ]');
    json = json.replaceAll(RegExp(','), ',\n    ');
    return json;
  }
}

enum JsonLabel {
  ///{
  LeftObject,

  ///}
  RightObject,

  ///[
  LeftArray,

  ///]
  RightArray,

  ///,
  Comma,
}
