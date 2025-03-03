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

  // 添加 API 列表
  final Map<String, String> apiEndpoints = {
    'GitHub 用户列表': 'https://api.github.com/users',
    'JSONPlaceholder 帖子': 'https://jsonplaceholder.typicode.com/posts',
    '随机用户数据': 'https://randomuser.me/api/',
    '天气数据(伦敦)': 'https://api.open-meteo.com/v1/forecast?latitude=51.5085&longitude=-0.1257&forecast_days=1',
    '狗狗图片': 'https://dog.ceo/api/breeds/image/random',
    '猫咪图片': 'https://api.thecatapi.com/v1/images/search',
    '比特币价格': 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT',
  };

  String selectedApi = 'GitHub 用户列表'; // 默认选中的 API

  @override
  void initState() {
    super.initState();
    showDebugBtn(context, btnColor: Colors.blue);
    controller.text = apiEndpoints[selectedApi]!;
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
              '选择一个 API 接口进行测试',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: selectedApi,
                isExpanded: true,
                items: apiEndpoints.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedApi = newValue;
                      controller.text = apiEndpoints[newValue]!;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'API URL',
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendRequest,
        child: Icon(Icons.send),
        tooltip: '发送请求',
      ),
    );
  }

  _sendRequest() async {
    httpGet(controller.text);
  }
}
