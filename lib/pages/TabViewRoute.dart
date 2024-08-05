import 'package:flutter/material.dart';

import 'KeepAliveWrapper.dart';

class TabViewRoute extends StatelessWidget {
  const TabViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    List tabs = ['新闻', '图片', '视频'];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabViewRoute'),
          bottom: TabBar(
            tabs: tabs.map((e)=> Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((e){
            return KeepAliveWrapper(
              child: Container(
                alignment: Alignment.center,
                child: Text(e),
              )
            );
          }).toList()
        )
      )
    );
    return const Placeholder();
  }
}
