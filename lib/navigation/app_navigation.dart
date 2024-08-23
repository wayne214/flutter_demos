import 'package:flutter/material.dart';

import '../muyu/muyu_page.dart';
import 'app_bottom_bar.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;
  final PageController _ctrl = PageController();

  final List<MenuData> menus = [
    const MenuData(label: '猜数字', icon: Icons.question_answer_outlined),
    const MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    const MenuData(label: '白板绘制', icon: Icons.palette_outlined),
    const MenuData(label: '网络文章', icon: Icons.article_outlined),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(),
      bottomNavigationBar: AppBottomBar(currentIndex: _index, menus: menus, onItemTap: _onChangePage),
    );
  }

  void _onChangePage(int index) {
    _ctrl.jumpToPage(index);
    setState(() {
      _index = index;
    });
  }

  Widget _buildContext() {
    return PageView(
      controller: _ctrl,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
          MuyuPage(),
          MuyuPage(),
      ],
    );
  }
}
