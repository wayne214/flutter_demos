import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const PaperAppBar(
      {super.key, required this.onClear, this.onBack, this.onRevocation});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackUpButtons(onBack: onBack, onRevocation: onRevocation),
      leadingWidth: 100,
      title: const Text('Paper'),
      actions: [
        IconButton(
          onPressed: onClear,
          splashRadius: 20,
          icon: const Icon(
            CupertinoIcons.delete,
            size: 20,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;
  const BackUpButtons({super.key, this.onBack, this.onRevocation});

  @override
  Widget build(BuildContext context) {
    const BoxConstraints cts = BoxConstraints(minHeight: 32, minWidth: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.blue;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.blue;
    return Center(
      child: Wrap(
        children: [
          Transform.scale(
            scaleX: -1,
            child: IconButton(
              splashRadius: 20,
              constraints: cts,
              onPressed: onBack,
              icon: Icon(Icons.next_plan_outlined, color: backColor,)
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: onRevocation,
            constraints: cts,
            icon: Icon(Icons.next_plan_outlined, color: revocationColor,)
          )
        ],
      ),
    );
  }
}

