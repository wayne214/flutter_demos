import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({super.key});

  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  var data = <String>[];
  int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (int i = 0; i < counter; i++) {
      data.add('Item ${i + 1}');
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedList'),),
      body: Stack(
        children: [
          AnimatedList(
            key: globalKey,
            initialItemCount: data.length,
            itemBuilder: (context, index, animation) {
              return FadeTransition(opacity: animation, child: buildItem(context, index));
            },
          ),
          buildAddBtn(),
        ],
      ),
    );
  }

  Widget buildAddBtn(){
    return Positioned(bottom: 30, left: 0, right: 0,child: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        data.add("${++counter}");

        globalKey.currentState?.insertItem(data.length - 1);
      },
    ),);
  }

  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(context, index) {
    setState(() {
      globalKey.currentState?.removeItem(index, (context, animation) {
        var item = buildItem(context, index);

        data.removeAt(index);

        return FadeTransition(opacity: CurvedAnimation(
          parent: animation,
          curve: const Interval(0.5, 1.0),
        ), child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: 0.0,
          child: item,
        ),);
      }, duration: const Duration(milliseconds: 200));

    });
  }
}
