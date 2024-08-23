import 'package:flutter/material.dart';

class MuyuAppBar extends StatelessWidget implements PreferredSizeWidget{
  final VoidCallback? onTapHistory;

  const MuyuAppBar({super.key, required this.onTapHistory});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('电子木鱼'),
      actions: [
        IconButton(
          onPressed: onTapHistory,
          icon: const Icon(Icons.history),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
