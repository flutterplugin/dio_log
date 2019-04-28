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
            Clipboard.setData(ClipboardData(text: response?.data?.toString()));
          },
          child: Text('复制结果'),
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

  ///构建jsonView
  Widget buildJsonView(String json) {
    _findReCentLabel(json);
  }

  JsonLabel _findReCentLabel(String json) {
    int position = -1;
    position = json.indexOf(RegExp('{'));
    if (position == 0) {
      return JsonLabel.LeftObject;
    }
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
