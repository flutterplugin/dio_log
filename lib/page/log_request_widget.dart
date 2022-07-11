import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_log/bean/net_options.dart';
import 'package:flutter/material.dart';

import '../dio_log.dart';

class LogRequestWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogRequestWidget(this.netOptions);

  @override
  _LogRequestWidgetState createState() => _LogRequestWidgetState();
}

class _LogRequestWidgetState extends State<LogRequestWidget>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _urlController;
  late TextEditingController _cookieController;
  late TextEditingController _paramController;
  late TextEditingController _bodyController;
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
    super.build(context);
    var reqOpt = widget.netOptions.reqOptions!;
    var resOpt = widget.netOptions.resOptions;

    ///格式化请求时间
    var requestTime = getTimeStr(reqOpt.requestTime!);

    ///格式化返回时间
    var responseTime = getTimeStr(resOpt?.responseTime ?? reqOpt.requestTime!);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tip: long press a key to copy the value to the clipboard',
              style: TextStyle(fontSize: 10, color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                copyClipboard(
                    context,
                    'url:${reqOpt.url}\nmethod:${reqOpt.method}\nrequestTime:$requestTime\nresponseTime:$responseTime\n'
                    'duration:${resOpt?.duration ?? 0}ms\n${dataFormat(reqOpt.data)}'
                    '\nparams:${toJson(reqOpt.params)}\nheader:${reqOpt.headers}');
              },
              child: Text('copy all'),
            ),
            _buildKeyValue('url', reqOpt.url),
            _buildKeyValue('method', reqOpt.method),
            _buildKeyValue('requestTime', requestTime),
            _buildKeyValue('responseTime', responseTime),
            _buildKeyValue('duration', '${resOpt?.duration ?? 0}ms'),
            _buildParam(reqOpt.data),
            _buildJsonView('params', reqOpt.params),
            _buildJsonView('header', reqOpt.headers),
          ],
        ),
      ),
    );
  }

  ///构建json树的展示
  Widget _buildJsonView(key, json) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getDefText('$key:'),
        JsonView(json: json),
      ],
    );
  }

  ///构建子节点的展示
  Widget _buildKeyValue(k, v) {
    Widget w = _getDefText('$k:${v is String ? '$v' : v?.toString() ?? null}');
    if (k != null) {
      w = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onLongPress: () {
          copyClipboard(context, v);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: w,
        ),
      );
    }
    return w;
  }

  ///默认的文本大小
  Text _getDefText(String str) {
    return Text(
      str,
      style: TextStyle(fontSize: 15),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Map? formDataMap;
  Widget _buildParam(dynamic data) {
    if (data is Map) {
      return _buildJsonView('body', data);
    } else if (data is FormData) {
      formDataMap = Map()
        ..addEntries(data.fields)
        ..addEntries(data.files);
      return _getDefText('formData:${map2Json(formDataMap)}');
    } else if (data is String) {
      try {
        var decodedMap = json.decode(data);
        return _buildJsonView('body', decodedMap);
      } catch (e) {
        return Text('body: $data');
      }
    } else {
      return SizedBox();
    }
  }

  String dataFormat(dynamic data) {
    if (data is FormData) {
      return 'formData:${map2Json(formDataMap)}';
    } else {
      return 'body:${toJson(data)}';
    }
  }
}
