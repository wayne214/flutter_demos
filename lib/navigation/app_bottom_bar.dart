import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuData {
  final String label;
  final IconData icon;

  const MenuData({required this.label, required this.icon});
}

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<MenuData> menus;
  final ValueChanged<int>? onItemTap;

  const AppBottomBar({super.key, this.currentIndex = 0, required this.menus, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onItemTap,
        currentIndex: currentIndex,
        elevation: 3,
        type: BottomNavigationBarType.fixed,
        iconSize: 22,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: menus.map(wItem).toList());
  }

  BottomNavigationBarItem wItem(MenuData menu) {
    return BottomNavigationBarItem(
      icon: Icon(menu.icon),
      label: menu.label,
    );
  }
}
