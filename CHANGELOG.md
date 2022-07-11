## [v2.0.4] - 2022/07/11
* remove WidgetsBinding.instance.addPostFrameCallback was replaced by await Future.delayed(Duration(milliseconds: 500));
## [v2.0.3] - 2021/06/13
* fix flutter 3.0 warning of WidgetsBinding
* Add the isError method implementation to LogPoolManager so that request messages defined as errors are displayed in red font
## [v2.0.2] - 2021/03/22
* fix copy Clipboard error
* Response header values can be copied
## [v2.0.1] - 2021/10/15
* response add headers
* overlay_draggable_button can set the color
## [v2.0.0] - 2021/04/01
* stable version
* Happy April Fools' Day
## [v2.0.0-nullsafety.0] - 2021/03/30
* Dio 4.0.0 support.
* Migrated to Flutter 2 and Better Theme support.
* Migrated to null safety.
* to public API add doc comments
* use ElevatedButton instead of RaisedButton
## [v1.3.5] - 2020/09/04
* ShowDebugBtn on WidgetsBinding.Instance.AddPostFrameCallback callback
* Adds a body of type FormData According to
* Adds a body of type string According to
## [v1.3.4] - 2020/2/03
* add replication request information
## [v1.3.3] - 2019/9/18
* Support dio > 3.0.0
## [v1.3.2] - 2019/9/18
* Support Flutter Web
* Support dio >2.2.1 
* if you dio version < 2.2.1, please use dio_log:1.3.1
## [v1.3.1] - 2019/9/05
* fix shrink and expand bug
## [v1.3.0] - 2019/8/21
* Optimize the request display UI
* HttpLogInterceptor Deprecated and change it to DioLogInterceptor
## [v1.2.1] - 2019/8/05
* add example project
* Fix the response parsing bug
## [v1.2.0] - 2019/8/01
* add overlay_draggable_button(Global float window is easier to open HttpLogListWidget)
* add clear log function at requestList
* add display requestTime at requestList
## [v1.1.1] - 2019/7/22
* add Screenshot
## [v1.1.0] - 2019/7/22
* support jsonView look at json
## [v1.0.3] - 2019/7/16
* fix some code
* Lower the version needed by dio
## [v1.0.2] - 2019/7/16
* Add description information and example
## [v1.0.1] - 2019/6/6
* Add a display of the body content to the request
* Logs with failed requests are shown in red in the list
## [v1.0.0] - 2018/09/04

* initial version
