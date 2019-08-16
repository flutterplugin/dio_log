import 'dart:collection';

import 'package:flutter/material.dart';

import 'dio_log.dart';
import 'page/log_widget.dart';
import 'theme/style.dart';

///网络请求日志列表
class HttpLogListWidget extends StatefulWidget {
  @override
  _HttpLogListWidgetState createState() => _HttpLogListWidgetState();
}

class _HttpLogListWidgetState extends State<HttpLogListWidget> {
  LinkedHashMap<String, HttpLog> logMap;
  List<String> keys;

  @override
  Widget build(BuildContext context) {
    logMap = LogPoolManage.getInstance().logMap;
    keys = LogPoolManage.getInstance().keys;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'request log',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF4a4a4a),
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Color(0xFF555555)),
        actions: <Widget>[
          InkWell(
            onTap: () {
              if (debugBtnIsShow()) {
                dismissDebugBtn();
              } else {
                showDebugBtn(context, isDelay: false);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  debugBtnIsShow() ? 'close overlay' : 'open overlay',
                  style: Style.defTextBold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              LogPoolManage.getInstance().clear();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  'clear',
                  style: Style.defTextBold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: logMap.length < 1
          ? Center(
              child: Text('no request log'),
            )
          : ListView.builder(
              reverse: false,
              itemCount: keys.length,
              itemBuilder: (BuildContext context, int index) {
                HttpLog item = logMap[keys[index]];
                return _buildItem(item);
              },
            ),
    );
  }

  Widget _buildItem(HttpLog item) {
    var options = item.options;

    ///格式化请求时间
    var requestTime = getTimeStr1(DateTime.fromMillisecondsSinceEpoch(
        options.queryParameters[HttpLogInterceptor.reqTimeKey]));

    Color textColor = (item.response?.data == null) ? Colors.red : Colors.black;
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LogWidget(item);
          }));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'url:${item.options.baseUrl + item.options.path}',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Divider(height: 2),
              Text(
                'status: ${item?.response?.statusCode ?? item?.err?.response?.statusCode}',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Divider(height: 2),
              Text(
                'requestTime: $requestTime',
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
