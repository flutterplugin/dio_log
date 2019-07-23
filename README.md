
# dio_log

http requests log of dio

### Add dependency
```
dependencies: dio_log : ^1.1.1 #^latest_version
```
### set interceptor of dio
```
dio.interceptors.add(HttpLogInterceptor());
```
### open log of dio list
``` 
Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HttpLogListWidget(),
    ),
  );
```
### Screenshot 

<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_list.PNG" width="220">      
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_request.PNG" width="220">
<img src="https://raw.githubusercontent.com/flutterplugin/dio_log/develop/images/log_response.PNG" width="220">
