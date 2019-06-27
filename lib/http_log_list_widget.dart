import 'dart:collection';

import 'package:flutter/material.dart';

import 'dio_log_export.dart';

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
          '网络日志',
          style: TextStyle(
              fontSize: 18.0,
              color: Color(0xFF4a4a4a),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Color(0xFF555555)),
      ),
      body: logMap.length < 1
          ? Center(
              child: Text('没有收到网络日志'),
            )
          : ListView.builder(
              reverse: false,
              itemCount: keys.length,
              itemBuilder: (BuildContext context, int index) {
                HttpLog item = logMap[keys[index]];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 1.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HttpLogWidget(item);
                      }));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.0),
                      child: Hero(
                        tag: item.options
                            .queryParameters[HttpLogInterceptor.reqTimeKey],
                        child: Text(
                          item.options.baseUrl + item.options.path,
                          style: TextStyle(
                              color: (item.response?.data == null)
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
