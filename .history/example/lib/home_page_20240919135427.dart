import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';

import 'http_utils.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  String url = 'https://api.github.com/users';

  @override
  void initState() {
    super.initState();
    showDebugBtn(context, btnColor: Colors.blue);
    controller.text = url;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'enter the requesr you want to send and press the send button',
            ),
            TextField(
              controller: controller,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendRequest,
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _sendRequest() async {
    httpGet(controller.text);
  }
}
