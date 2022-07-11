
# dio_log
[![pub package](https://img.shields.io/pub/v/dio_log.svg)](https://pub.dev/packages/dio_log)
#### HTTP Inspector tool for Dart which can debugging http requests，Currently, DIO based HTTP capture is implemented
#### Of course, you can implement an Interceptor instead of a DiologInterceptor to adapt to other HTTP clients
#### flutter的HTTP检查器工具，可以帮助调试HTTP请求，目前实现了基于dio的http捕获
#### 当然你可以通过自己实现Interceptor来代替DioLogInterceptor来适配其他Http client

### Add dependency
### 添加依赖
```
dependencies: 
  dio_log : ^2.0.3
```
### [github](https://github.com/flutterplugin/dio_log)
```
dio_log:
  git:
  url: git@github.com:flutterplugin/dio_log.git
  ref: v2.0.3
```
### set interceptor of dio
### 给dio设置监听
```
dio.interceptors.add(DioLogInterceptor());
```
### Add a global hover button on your home page to jump through the log list
### 在你的主页面添加全局的悬浮按钮，用于跳转日志列表
```
///display overlay button 显示悬浮按钮
showDebugBtn(context,btnColor: Colors.blue);
///cancel overlay button 取消悬浮按钮
dismissDebugBtn();
///overlay button state of display 悬浮按钮展示状态
debugBtnIsShow()
```
### Or open a log list where you want it to be
### 或者在你期望的地方打开日志列表
``` 
Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HttpLogListWidget(),
    ),
  );  
```
### Other configurable parameters
### 其他可设置参数
```
/// Sets the maximum number of entries for logging 设置记录日志的最大条数
LogPoolManager.getInstance().maxCount = 100;
///Add the isError method implementation to LogPoolManager so that request messages defined as errors are displayed in red font
LogPoolManager.getInstance().isError = (res) => res.resOptions==null;
///Disabling Log Printing
DioLogInterceptor.enablePrintLog = false;
```

### Screenshot 
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_list.jpg" width="200">      
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_request.jpg" width="200">
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_response.jpg" width="200">

### gif demo 
![gif](https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/dio_log_example.gif)
### welcome to add my WeChat,Hand over a friend
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/wechat.png" width="200">