import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/pages/AnimatedListPage.dart';
import 'package:flutter_demos/pages/DecoratedPage.dart';
import 'package:flutter_demos/pages/DialogPage.dart';
import 'package:flutter_demos/pages/DioRequestPage.dart';
import 'package:flutter_demos/pages/FirstPage.dart';
import 'package:flutter_demos/pages/FourPage.dart';
import 'package:flutter_demos/pages/GetStateObjectRoute.dart';
import 'package:flutter_demos/pages/HttpRequestPage.dart';
import 'package:flutter_demos/pages/InfiniteGridView.dart';
import 'package:flutter_demos/pages/NestedTabBarView.dart';
import 'package:flutter_demos/pages/ScaffoldPage.dart';
import 'package:flutter_demos/pages/ScrollablePage.dart';
import 'package:flutter_demos/pages/SecondPage.dart';
import 'package:flutter_demos/pages/SocketPage.dart';
import 'package:flutter_demos/pages/ThirdPage.dart';
import 'package:flutter_demos/pages/WebSocketPage.dart';

void collectLog(String line){
  //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details){
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
  // 构建错误信息
  return FlutterErrorDetails(
    exception: obj,
    stack: stack,
    library: 'Flutter Demo',
    context: ErrorDescription('测试错误'),
    informationCollector: () sync* {
      yield ErrorSummary("错误");
    }
  );
}

void main() {
  // 捕获异常
  var onError = FlutterError.onError;
  FlutterError.onError = (details) {
    onError?.call(details);
    if (kDebugMode) {
      reportErrorAndLog(details);
      // reportError(details);
    }
  };
  // 捕获异常
  runZoned(()=> runApp(const MyApp()), zoneSpecification: ZoneSpecification(
    // 拦截print
    print: (self, parent, zone,line) {
      collectLog(line);
      parent.print(zone, line);
    },
      //拦截未处理的异步错误
    handleUncaughtError: (self, parent, zone, error, stack) {
      // reportErrorAndLog(details);
      parent.print(zone, '${error.toString()}} $stack');
    }
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        'getStateObject': (context) => const GetStateObjectRoute(),
        'secondPage': (context) => const SecondPage(),
        'firstPage': (context) => const FirstPage(),
        'thirdPage': (context) => const ThirdPage(),
        'fourPage': (context) => const FourPage(),
        'decoratedPage': (context) => const DecoratedPage(),
        'scaffoldPage': (context) => const ScaffoldPage(),
        'scrollablePage': (context) => const ScrollablePage(),
        'animatedListPage': (context) => const AnimatedListPage(),
        'infiniteGridview': (context) => const InfiniteGridview(),
        'nestedTabBarView': (context) => const NestedTabBarView(),
        'dialogPage': (context) => const DialogPage(),
        'httpRequestPage': (context) => const HttpRequestPage(),
        'dioRequestPage': (context) => const DioRequestPage(),
        'webSocketPage': (context) => const WebSocketPage(),
        'socketPage': (context) => const SocketPage(),
        // '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          //// 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          //        // 引导用户登录；其他情况则正常打开路由。
          if (settings.name == '/') {
            return const MyHomePage(title: 'Flutter Demo Home Page');
          } else if (settings.name == 'getStateObject') {
            return const GetStateObjectRoute();
          } else if (settings.name == 'secondPage') {
            return const SecondPage();
          } else if (settings.name == 'firstPage') {
            return const FirstPage();
          } else {
            return const Scaffold(
              body: Center(
                child: Text('404'),
              ),
            );
          }
        });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  int _counter = 0;

  String listData = "";

  void _incrementCounter() {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
    // 路由导航--非命名路由方式
    var result = Navigator.push(context, MaterialPageRoute(builder: (context){
      return const FirstPage();
    }));

    if (kDebugMode) {
      print("路由返回结果：$result");
    }

    // 路由导航--命名路由方式
    // Navigator.pushNamed(context, 'secondPage', arguments: '我是参数');
  }

  Future<String> getData() async{
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse('https://www.baidu.com'));

    var response = await request.close();

    if(response.statusCode == 200) {
      var data = await response.transform(utf8.decoder).join();
      listData = data;
      return data;
    } else {
      return 'error';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    getData().then((value) {
      setState(() {
        listData = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // SizedBox(height: 400, child: Text(listData),),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'socketPage');
              },
              child: const Text('跳转页面'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
