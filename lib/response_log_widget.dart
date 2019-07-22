import 'package:dio_log/log_pool_manage.dart';
import 'package:flutter/material.dart';

import 'json_view.dart';

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
    if (response.data == null) {
      return Center(
        child: Text('No response received'),
      );
    }
    Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return SingleChildScrollView(child: JsonView(data));
  }
}
