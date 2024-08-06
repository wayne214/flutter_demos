import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {

  // 显示底部菜单列表
  Future<int?> _showModalBottomSheet() {
    return showModalBottomSheet<int>(context: context, builder: (context){
      return ListView.builder(itemCount: 30, itemBuilder: (context, index) {
        return ListTile(
          title: Text("item $index"),
          onTap: ()=> Navigator.pop(context, index),
        );
      });
    });
  }
  // 显示一个加载弹框
  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            children: [
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.all(10), child: Text("正在加载..."))
            ],
          ),
        );
      },
    );
  }
  // 显示一个有固定大小的弹框
  showSizedLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 200,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.all(10), child: Text("正在加载..."))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DialogPage"),), body: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                    title: const Text("title"),
                    content: const Text("content"),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text("取消")),
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text("确定"))
                    ]
                );
              });
            }, child: const Text("打开弹框"),),


            ElevatedButton(onPressed: () async {
              int? type = await _showModalBottomSheet();
              if (kDebugMode) {
                print("type: $type");
              }
            }, child: const Text("显示底部菜单列表")),

            ElevatedButton(onPressed: () async {
              showSizedLoadingDialog();
            }, child: const Text("显示加载框"))
          ],
        )
    ),);
  }
}
