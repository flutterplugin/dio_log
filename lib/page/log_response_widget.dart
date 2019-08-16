import 'package:dio_log/utils/log_pool_manage.dart';
import 'package:dio_log/widget/json_view.dart';
import 'package:flutter/material.dart';

class LogResponseWidget extends StatefulWidget {
  final HttpLog httpLog;

  LogResponseWidget(this.httpLog);

  @override
  _LogResponseWidgetState createState() => _LogResponseWidgetState();
}

class _LogResponseWidgetState extends State<LogResponseWidget> {
  @override
  Widget build(BuildContext context) {
    var response = widget.httpLog.response;
    if (response?.data == null) {
      return Center(
        child: Text('No response received'),
      );
    }
    return SingleChildScrollView(child: JsonView(response?.data));
  }
}
