
# dio_log

#### http requests log of dio 
#### 基于dio的网络请求日志

### Add dependency
### 添加依赖
```
dependencies: dio_log : ^1.2.0 #^latest_version
```
### set interceptor of dio
### 给dio设置监听
```
dio.interceptors.add(HttpLogInterceptor());
```
### Add a global hover button on your home page to jump through the log list
### 在你的主页面添加全局的悬浮按钮，用于跳转日志列表
```
showDebugBtn(context);
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

### Screenshot 
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_list.PNG" width="200">      
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_request.PNG" width="200">
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_response.PNG" width="200">

### gif demo 
![gif](https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/dio_log_example.gif)
