import 'package:flutter/material.dart';

class InfiniteGridview extends StatefulWidget {
  const InfiniteGridview({super.key});

  @override
  State<InfiniteGridview> createState() => _InfiniteGridviewState();
}

class _InfiniteGridviewState extends State<InfiniteGridview> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();

    _retrieveIcons();
  }

  void _retrieveIcons() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InfiniteGridview"),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: _icons.length,
          itemBuilder: (context, index) {
            if (index == _icons.length - 1 && _icons.length < 10) {
              _retrieveIcons();
            }
            return Icon(_icons[index]);
          }),
    );
  }
}
