import 'package:dio_log/http_log_interceptor.dart';
import 'package:dio_log/log_pool_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestLogWidget extends StatefulWidget {
  final HttpLog httpLog;

  RequestLogWidget(this.httpLog);

  @override
  _RequestLogWidgetState createState() => _RequestLogWidgetState();
}

class _RequestLogWidgetState extends State<RequestLogWidget> {
  TextEditingController _urlController;
  TextEditingController _cookieController;
  TextEditingController _paramController;
  TextEditingController _bodyController;
  bool reqFail = false;
  @override
  void initState() {
    _urlController = TextEditingController();
    _cookieController = TextEditingController();
    _paramController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _paramController.dispose();
    _urlController.dispose();
    _cookieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var options = widget.httpLog.options;

    ///格式化请求时间
    var requestTime = _getTimeStr(DateTime.fromMillisecondsSinceEpoch(
        options.queryParameters[HttpLogInterceptor.reqTimeKey]));

    ///格式化返回时间
    var resTime = options.queryParameters[HttpLogInterceptor.resTimeKey];
    if (resTime == null) {
      reqFail = true;
      resTime = 0;
    }
    var responseTime = reqFail
        ? '请求失败'
        : _getTimeStr(DateTime.fromMillisecondsSinceEpoch(resTime));

    ///计算请求耗时
    var duration =
        '${resTime - options.queryParameters[HttpLogInterceptor.reqTimeKey]}ms';
    if (reqFail) {
      duration = '遥遥无期';
    }

    ///拼接实际请求链接
    StringBuffer str = StringBuffer(options.baseUrl + options.path + '?');
    options.queryParameters.forEach((key, value) {
      if (key == HttpLogInterceptor.resTimeKey) {
      } else {
        str.write('$key=$value&');
      }
    });
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildItem('method', options.method),
          _buildItem('requestTime', requestTime),
          _buildItem('responseTime', responseTime),
          _buildItem('duration', duration),
          _buildCopyItem('requestUrl', str.toString() ?? '', _urlController),
          _buildCopyItem(
              'body', options.data.toString() ?? '', _bodyController),
          _buildCopyItem('params', options.queryParameters.toString() ?? '',
              _paramController),
          _buildCopyItem(
              'cookie', options.headers['cookie'] ?? '', _cookieController),
        ],
      ),
    );
  }

  _buildItem(key, value) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 120.0,
            child: Text(
              key + '      ',
              style: TextStyle(
                  fontSize: 16.0, color: reqFail ? Colors.red : Colors.black),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                value,
                maxLines: 4,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    fontSize: 13.0, color: reqFail ? Colors.red : Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildCopyItem(key, value, TextEditingController controller) {
    OutlineInputBorder inputBorder = new OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black, style: BorderStyle.solid, width: 1.0));

    controller.text = value;
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              key,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              child: Text('copy'),
              onPressed: () {
                var snackBar = SnackBar(content: Text('copy success'));
                Scaffold.of(context).showSnackBar(snackBar);
                Clipboard.setData(ClipboardData(text: value));
              },
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              fillColor: Color(0xFFF8F8F8),
              filled: true,
              enabledBorder: inputBorder,
              border: inputBorder,
              focusedBorder: inputBorder,
            ),
          ),
        )
      ],
    );
  }

  ///format(2018.09.08  08.20 11:22)
  String _getTimeStr(DateTime dateTime) {
    return "${twoNum(dateTime.year)}.${twoNum(dateTime.month)}.${twoNum(dateTime.day)}    ${twoNum(dateTime.hour)}:${twoNum(dateTime.minute)}:${dateTime.millisecond}";
  }

  ///转成两位数
  String twoNum(int num) {
    return num > 9 ? num.toString() : "0$num";
  }
}
