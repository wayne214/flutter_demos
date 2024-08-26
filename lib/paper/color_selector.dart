import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const ColorSelector(
      {super.key,
      required this.colors,
      required this.onSelect,
      required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Wrap(
          children: List.generate(
        colors.length,
        _buildItem,
      )),
    );
  }

  Widget _buildItem(int index) {
    bool selected = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(2),
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: selected ? Border.all(color: Colors.blue) : null),
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: colors[index]),
        ),
      ),
    );
  }
}
