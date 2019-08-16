import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

copyClipboard(BuildContext context, String value) {
  var snackBar = SnackBar(content: Text('copy $value to clipboard'));
  Scaffold.of(context).showSnackBar(snackBar);
  Clipboard.setData(ClipboardData(text: value));
}
