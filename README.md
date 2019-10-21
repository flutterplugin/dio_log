
# dio_log
[![pub package](https://img.shields.io/pub/v/dio_log.svg)](https://pub.dev/packages/dio_log)
#### http requests log of dio 
#### 基于dio的网络请求日志

### Add dependency
### 添加依赖
```
dependencies: 
  dio_log : ^1.3.3
```
### [github](https://github.com/flutterplugin/dio_log)
```
dio_log:
  git:
  url: git@github.com:flutterplugin/dio_log.git
  ref: develop
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
showDebugBtn(context);
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
```

### Screenshot 
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_list.jpg" width="200">      
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_request.jpg" width="200">
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_response.jpg" width="200">

### gif demo 
![gif](https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/dio_log_example.gif)
