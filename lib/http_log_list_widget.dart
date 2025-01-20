import 'dart:collection';

import 'package:dio_log/widget/input_dialog.dart';
import 'package:flutter/material.dart';

import 'bean/net_options.dart';
import 'dio_log.dart';
import 'page/log_widget.dart';

///网络请求日志列表
class HttpLogListWidget extends StatefulWidget {
  @override
  _HttpLogListWidgetState createState() => _HttpLogListWidgetState();
}

class _HttpLogListWidgetState extends State<HttpLogListWidget> {
  LinkedHashMap<String, NetOptions>? logMap;
  List<String>? keys;
  SearchModel? searchModel;
  @override
  Widget build(BuildContext context) {
    logMap = LogPoolManager.getInstance().logMap;
    if (searchModel != null) {
      keys = LogPoolManager.getInstance().keys.where((element) {
        var model = logMap![element]!;
        var req = model.reqOptions;
        var urlValid = req!.url!.contains(searchModel!.url);
        var res = model.resOptions;
        var statusValid;
        if (searchModel?.status == 0) {
          statusValid = true;
        } else {
          statusValid = res?.statusCode == searchModel?.status;
        }
        var isError = LogPoolManager.getInstance().isError(model);
        var duration = searchModel?.duration ?? 0;
        var durationType = searchModel?.durationType ?? 0;
        var isDuration = true;
        if (durationType == 0) {
          isDuration = (model.resOptions?.duration ?? 0) > duration;
        }
        if (durationType == 1) {
          isDuration = (model.resOptions?.duration ?? 0) < duration;
        }
        return urlValid && statusValid && isError == searchModel?.isError && isDuration;
      }).toList();
    } else {
      keys = LogPoolManager.getInstance().keys;
    }

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logs',
          style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1.0,
        iconTheme: theme.iconTheme,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              searchModel = SearchModel.noCondition();
              setState(() {});
              snackBar(context, 'show All Logs');
            },
            child: Align(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'show All',
                  style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              searchModel = await showInputDialog(context);
              setState(() {});
              snackBar(context, 'Filtered by condition');
            },
            child: Icon(Icons.search),
          ),
          InkWell(
            onTap: () {
              if (debugBtnIsShow()) {
                dismissDebugBtn();
              } else {
                showDebugBtn(context);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  debugBtnIsShow() ? 'close overlay' : 'open overlay',
                  style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              LogPoolManager.getInstance().clear();
              setState(() {});
              snackBar(context, 'clear Logs');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  'clear',
                  style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: logMap?.isEmpty ?? true
          ? Center(
              child: Text('no request log'),
            )
          : ListView.builder(
              reverse: false,
              itemCount: keys!.length,
              itemBuilder: (BuildContext context, int index) {
                NetOptions item = logMap![keys![index]]!;
                return _buildItem(item);
              },
            ),
    );
  }

  ///构建请求的简易信息
  Widget _buildItem(NetOptions item) {
    var resOpt = item.resOptions;
    var reqOpt = item.reqOptions!;

    ///格式化请求时间
    var requestTime = getTimeStr1(reqOpt.requestTime!);

    Color? textColor =
        LogPoolManager.getInstance().isError(item) ? Colors.red : Theme.of(context).textTheme.bodyLarge!.color;
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
                'url: ${reqOpt.url}',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Divider(height: 2),
              Text(
                'status: ${resOpt?.statusCode}',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Divider(height: 2),
              Text(
                'requestTime: $requestTime    duration: ${resOpt?.duration ?? 0}ms',
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
