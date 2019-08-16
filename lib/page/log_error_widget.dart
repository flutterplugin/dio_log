import 'package:dio_log/bean/net_options.dart';
import 'package:flutter/material.dart';

class LogErrorWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogErrorWidget(this.netOptions);

  @override
  _LogErrorWidgetState createState() => _LogErrorWidgetState();
}

class _LogErrorWidgetState extends State<LogErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Center(
        child: Text(widget.netOptions.errOptions?.errorMsg ?? 'no error'),
      ),
    );
  }
}
