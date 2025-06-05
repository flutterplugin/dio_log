# dio_log
[![pub package](https://img.shields.io/pub/v/dio_log.svg)](https://pub.dev/packages/dio_log)

[English](README.md) | [中文](README_zh.md)

## 描述
这是一个用于 Dart 的 HTTP 检查器工具，可以帮助调试 HTTP 请求。目前实现了基于 dio 的 http 捕获功能。
当然，您可以通过自己实现 Interceptor 来代替 DioLogInterceptor 以适配其他 Http client。

## 安装
在您的 `pubspec.yaml` 文件中添加：
```yaml
dependencies:
  dio_log: 5.3.0+1
```

## 使用方法
1. 给 dio 设置拦截器：
```dart
dio.interceptors.add(DioLogInterceptor());
```

2. 在主页面添加全局悬浮按钮：
```dart
// 显示悬浮按钮
showDebugBtn(context, btnColor: Colors.blue);
// 取消悬浮按钮
dismissDebugBtn();
// 检查悬浮按钮显示状态
debugBtnIsShow()
```

3. 或者在需要的地方手动打开日志列表：
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => HttpLogListWidget(),
  ),
);
```

## 配置选项
```dart
// 设置记录日志的最大条数
LogPoolManager.getInstance().maxCount = 100;
// 添加自定义错误检测
LogPoolManager.getInstance().isError = (res) => res.resOptions==null;
// 禁用日志打印
DioLogInterceptor.enablePrintLog = false;
```

## 截图展示
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_list.jpg" width="200">      
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_request.jpg" width="200">
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_response.jpg" width="200">
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_filter.jpg" width="200">

## 演示
![gif](https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/dio_log_example.gif) 