import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class SocketPage extends StatelessWidget {
  const SocketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text("SocketPage")),
      body: FutureBuilder(future: _request(),
          builder: (context, snapShot) {
            if(snapShot.hasData){
              return Text(snapShot.data.toString());
            }else{
              return Text("loading");
            }
          }
      ),
    );
  }

  _request() async{
    // 创建socket
    var socket = await Socket.connect("www.baidu.com", 80);
    // 根据http协议，发送请求
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host: www.baidu.com");
    socket.writeln("Connection: close");
    socket.writeln("");
    await socket.flush(); // 发送
    // 读取响应内容，按照utf8编码
    String response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return response;

  }
}
