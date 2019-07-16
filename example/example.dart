import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() async {
  var dio = Dio();
  dio.interceptors.add(HttpLogInterceptor());

  ///this is context of widget
  BuildContext context;
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HttpLogListWidget(),
    ),
  );
}
