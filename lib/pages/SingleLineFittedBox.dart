import 'package:flutter/material.dart';

class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints){
      return FittedBox(
        // fit: BoxFit.contain,// 适配方式
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minWidth: constraints.maxWidth,
            maxWidth: double.infinity,
          ),
          child: child,
        ),
      );
    });
  }
}
