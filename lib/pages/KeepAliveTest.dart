import 'package:flutter/material.dart';
import 'package:flutter_demos/pages/KeepAliveWrapper.dart';

class KeepAliveTest extends StatelessWidget {
  const KeepAliveTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeepAliveTest'),
      ),
      body: ListView.builder(itemBuilder: (_, index) {
        return KeepAliveWrapper(keepAlive: true, child: ListItem(index: index,));
      }),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.index});

  final int index;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.index}'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
