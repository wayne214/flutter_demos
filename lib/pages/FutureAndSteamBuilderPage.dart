import 'package:flutter/material.dart';

class FSBuilderPage extends StatefulWidget {
  const FSBuilderPage({super.key});

  @override
  State<FSBuilderPage> createState() => _FSBuilderPageState();
}

class _FSBuilderPageState extends State<FSBuilderPage> {

  Stream<int> counter() {
    return Stream.periodic(const Duration(seconds: 1), (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("FutureBuilder")),body: Column(
      children: [
        FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3), () => "hello"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          }),

        StreamBuilder(stream: counter(), builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Error: ${snapshot.error}");
          }

          switch(snapshot.connectionState){
            case ConnectionState.none:
              return const Text("没有Steam");
            case ConnectionState.waiting:
              return const Text('等待数据');
            case ConnectionState.active:
              return Text("Active: ${snapshot.data}");
            case ConnectionState.done:
              return const Text("Stream已关闭");
          }
        })

      ],
    ),);
  }
}
