import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DioRequestPage extends StatefulWidget {
  const DioRequestPage({super.key});

  @override
  State<DioRequestPage> createState() => _DioRequestPageState();
}

class _DioRequestPageState extends State<DioRequestPage> {
  bool _loading = false;
  String _text = "";

  late Response response;

  final Dio _dio = Dio();

  request() async {
    setState(() {
      _loading = true;
      _text = "正在请求。。。";
    });

    try {
      response =
          await _dio.get('https://api.github.com/orgs/flutterchina/repos');

      if (response.statusCode == HttpStatus.ok) {
        _text = json.encode(response.data);
      } else {
        _text = "请求失败";
      }
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
      body: FutureBuilder(
          future: _dio.get('https://api.github.com/orgs/flutterchina/repos'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data as Response;

              if (kDebugMode) {
                print("请求数据：${response.data}");
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: response.data.length,
                  itemExtent: 100,
                  itemBuilder: (context, index) {
                    if (kDebugMode) {
                      print("请求数据ddd：${response.data[index]}");
                    }

                    return ListTile(
                      title: Text(response.data[index]['full_name']),
                      subtitle: Text(response.data[index]['description'] ?? ""),
                      leading: CircleAvatar(child: Image.network(response.data[index]['owner']['avatar_url']),),
                    );
                  });
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
