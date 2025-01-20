import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///复制到粘贴板
copyClipboard(BuildContext context, String? value) {
  snackBar(context,'$value\n\n copy success to clipboard');
  Clipboard.setData(ClipboardData(text: value ?? 'null'));
}

snackBar(BuildContext context, String? value){
  var snackBar =
      SnackBar(content: Text('$value'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}