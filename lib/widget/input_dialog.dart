import 'package:dio_log/utils/copy_clipboard.dart';
import 'package:flutter/material.dart';

class SearchModel {
  String url;
  int status;
  // String time;
  // int timeType; //0>,1<
  int duration;
  int durationType; //0>,1<
  bool isError;

  SearchModel(
    this.url,
    this.status,
    // this.time,
    // this.timeType,
    this.duration,
    this.durationType,
    this.isError,
  );

  SearchModel.noCondition({
    this.url = '',
    this.status = 0,
    // this.time,
    // this.timeType,
    this.duration = 0,
    this.durationType = 0,
    this.isError = false,
  });
}

Future<SearchModel?> showInputDialog(BuildContext context) async {
  TextEditingController _urlTextFieldController = TextEditingController();
  TextEditingController _statusTextFieldController = TextEditingController();
  TextEditingController _duration1TextFieldController = TextEditingController();
  TextEditingController _durationTextFieldController = TextEditingController();
  ValueNotifier<bool> valueListenable = ValueNotifier(false);
  return await showDialog(
    context: context,
    builder: (context1) {
      return AlertDialog(
        title: Text('Search Key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _urlTextFieldController,
              decoration: InputDecoration(hintText: "url:"),
            ),
            TextField(
              controller: _statusTextFieldController,
              decoration: InputDecoration(hintText: "status:"),
            ),
            TextField(
              controller: _duration1TextFieldController,
              decoration: InputDecoration(hintText: ">duration(ms):"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _durationTextFieldController,
                    decoration: InputDecoration(hintText: "<duration(ms):"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('isError', style: TextStyle(color: Colors.red)),
                ValueListenableBuilder(
                  valueListenable: valueListenable,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Checkbox(
                      value: valueListenable.value,
                      onChanged: (v) {
                        valueListenable.value = v??false;
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              var duration1 = _duration1TextFieldController.text;
              var duration = _durationTextFieldController.text;
              var du = 0;
              var duType = 0;
              if (duration.isNotEmpty && duration1.isNotEmpty) {
                return snackBar(context, 'duration> and duration< not both exist');
              }
              if (duration1.isNotEmpty) {
                du = int.tryParse(duration1) ?? 0;
                duType = 0;
              }
              if (duration.isNotEmpty) {
                du = int.parse(duration) ?? 0;
                duType = 1;
              }
              var sm = SearchModel(
                _urlTextFieldController.text,
                int.tryParse(_statusTextFieldController.text) ?? 0,
                du,
                duType,
                valueListenable.value,
              );
              Navigator.of(context).pop(sm);
            },
          ),
        ],
      );
    },
  );
}
