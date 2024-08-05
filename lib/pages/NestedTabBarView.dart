import 'package:flutter/material.dart';

class NestedTabBarView extends StatelessWidget {
  const NestedTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final _tabs = ["猜你喜欢", "今日特价", "发现更多"];
    return DefaultTabController(length: _tabs.length, child: Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context), sliver: SliverAppBar(
              title: Text('商城'),
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(tabs: _tabs.map((String name)=> Tab(text: name,)).toList()),
            ),)
          ];
        },
        body: TabBarView(
          children: _tabs.map((String name){
            return Builder(
              builder: (context){
                return CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: [
                    SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: buildSliverList(50),
                    )
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(delegate: SliverChildBuilderDelegate((context, index){
      return ListTile(title: Text('$index'),);
    }), itemExtent: 50);
  }

}
