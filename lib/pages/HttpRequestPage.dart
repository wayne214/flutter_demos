import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpRequestPage extends StatefulWidget {
  const HttpRequestPage({super.key});

  @override
  State<HttpRequestPage> createState() => _HttpRequestPageState();
}

class _HttpRequestPageState extends State<HttpRequestPage> {
  bool _loading = false;
  String _text = "";

  request() async {
    setState(() {
      _loading = true;
      _text = "正在请求。。。";
    });

    try {
      var url = Uri.parse("https://www.baidu.com");
      // var response = await HttpClient().getUrl(url).then((HttpClientRequest request) {
      //   return request.close();
      // }).then((HttpClientResponse response) {
      //   return response.transform(utf8.decoder).join();
      // });

      // 1.创建httpClient
      HttpClient httpClient = HttpClient();
      // 2.打开http链接, 设置请求头
      HttpClientRequest request = await httpClient.getUrl(url);
      // 使用iphone的UA,添加header
      request.headers.add(
        "user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      );
      // 3.等待服务器返回
      HttpClientResponse response = await request.close();
      // 4.读取响应内容
      _text = await response.transform(utf8.decoder).join();

      // 5.请求完成，关闭client后，通过该client发起的所有请求都会终止
      httpClient.close();
    } catch (e) {
      _text = "请求失败";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HttpRequestPage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(onPressed: _loading ? null : request, child: const Text("获取百度首页数据")),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(_text),
            )
          ],
        ),
      ),
    );
  }
}
