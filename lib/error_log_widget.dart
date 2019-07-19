import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';

class ErrorLogWidget extends StatefulWidget {
  final HttpLog httpLog;

  ErrorLogWidget(this.httpLog);

  @override
  _ErrorLogWidgetState createState() => _ErrorLogWidgetState();
}

class _ErrorLogWidgetState extends State<ErrorLogWidget> {
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
