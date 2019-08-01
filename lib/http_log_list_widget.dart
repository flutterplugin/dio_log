import 'dart:collection';

import 'package:flutter/material.dart';

import 'dio_log.dart';

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
          RaisedButton(
            onPressed: () {
              LogPoolManage.getInstance().clear();
              setState(() {});
            },
            child: Text('clear log'),
          )
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
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HttpLogWidget(item);
          }));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'requestTime: $requestTime',
                style: TextStyle(
                  color:
                      (item.response?.data == null) ? Colors.red : Colors.black,
                ),
              ),
              Divider(height: 2),
              Text(
                'url:${item.options.baseUrl + item.options.path}',
                style: TextStyle(
                  color:
                      (item.response?.data == null) ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
