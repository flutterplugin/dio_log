import 'package:dio_log/bean/net_options.dart';
import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';

class LogResponseWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogResponseWidget(this.netOptions);

  @override
  _LogResponseWidgetState createState() => _LogResponseWidgetState();
}

class _LogResponseWidgetState extends State<LogResponseWidget>
    with AutomaticKeepAliveClientMixin {
  bool isShowAll = false;
  double fontSize = 14;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var response = widget.netOptions.resOptions;
    var json = response?.data ?? 'no response';
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Text(isShowAll ? 'shrink all' : 'expand all'),
            Switch(
              value: isShowAll,
              onChanged: (check) {
                isShowAll = check;

                setState(() {});
              },
            ),
            Expanded(
              child: Slider(
                value: fontSize,
                max: 30,
                min: 1,
                onChanged: (v) {
                  fontSize = v;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Text(
          'Tip: long press a key to copy the value to the clipboard',
          style: TextStyle(
            fontSize: 10,
            color: Colors.red,
          ),
        ),
        _buildJsonView('headers:', response?.headers),
        _buildJsonView('response.data:', json),
      ],
    ));
  }

  ///构建json树的展示
  Widget _buildJsonView(key, json) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            copyClipboard(context, toJson(json));
          },
          child: Text('copy json'),
        ),
        Text(
          '$key',
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        JsonView(
          json: json,
          isShowAll: isShowAll,
          fontSize: fontSize,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
