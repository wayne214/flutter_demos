import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStateObjectRoute extends StatefulWidget {
  const GetStateObjectRoute({super.key});

  @override
  State<GetStateObjectRoute> createState() => _GetStateObjectRouteState();
}

class _GetStateObjectRouteState extends State<GetStateObjectRoute> {
  static final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: const Text('子树中获取 State对象')),
      body: Center(
        child: Column(
          children: [
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  ScaffoldState _state =
                      context.findAncestorStateOfType<ScaffoldState>()!;
                  // 打开c抽屉菜单
                  _state.openDrawer();
                },
                child: const Text('打开抽屉菜单 1'),
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  ScaffoldState _state = Scaffold.of(context);
                  // 打开c抽屉菜单
                  _state.openDrawer();
                },
                child: const Text('打开抽屉菜单 2'),
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('我是SnackBar')));
                },
                child: const Text('显示 SnackBar'),
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  _globalKey.currentState?.openDrawer();
                },
                child: const Text('globalKey打开抽屉菜单'),
              );
            }),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 1)),
              child: const Text('我是Container'),
            )
          ],
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
