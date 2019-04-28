import 'package:dio_log/dio_log_export.dart';
import 'package:flutter/material.dart';

///网络请求详情
class HttpLogWidget extends StatefulWidget {
  final HttpLog httpLog;

  HttpLogWidget(this.httpLog);

  @override
  _HttpLogWidgetState createState() => _HttpLogWidgetState();
}

class _HttpLogWidgetState extends State<HttpLogWidget>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "request"),
    new Tab(text: "response"),
  ];

  PageController _pageController;

  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget
              .httpLog.options.queryParameters[HttpLogInterceptor.reqTimeKey],
          child: Text(
            widget.httpLog.options.path,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF4a4a4a),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Color(0xFF555555)),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return RequestLogWidget(widget.httpLog);
          } else if (index == 1) {
            return ResponseLogWidget(widget.httpLog);
          } else {
            return ErrorLogWidget(widget.httpLog);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _bottomTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.network_wifi), title: Text('request')),
          BottomNavigationBarItem(
              icon: Icon(Icons.network_wifi), title: Text('response')),
          BottomNavigationBarItem(
              icon: Icon(Icons.network_wifi), title: Text('error')),
        ],
      ),
    );
  }

  void _onPageChanged(int value) {
    if (mounted) {
      setState(() {
        currentIndex = value;
      });
    }
  }

  void _bottomTap(int value) {
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}
