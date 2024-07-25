import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});


  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('第二页'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50,
            itemBuilder: (BuildContext context, int index){
          return DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
            child: const Text("data"),);
        }),
      ),
    );
  }
}
