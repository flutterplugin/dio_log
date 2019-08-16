import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';

class LogErrorWidget extends StatefulWidget {
  final HttpLog httpLog;

  LogErrorWidget(this.httpLog);

  @override
  _LogErrorWidgetState createState() => _LogErrorWidgetState();
}

class _LogErrorWidgetState extends State<LogErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Center(
        child: Text(widget.httpLog.err?.toString() ?? 'request success'),
      ),
    );
  }
}
