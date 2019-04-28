

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
# dio_log

dio网络请求日志插件

# 使用方法
### 引用
dio_log:
      git:
        url: ssh://git@gitlabssh.office.tengyue360.com:8042/cuidong/dio_log.git
        ref: v1.0.0
### 设置dio拦截器  
dio.interceptors.add(HttpLogInterceptor());
### 打开log日志列表
AppNavigatorUtils.push(context, HttpLogListWidget());