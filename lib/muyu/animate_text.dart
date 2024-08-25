import 'package:flutter/material.dart';
import 'package:flutter_demos/muyu/models/merit_record.dart';

class AnimateText extends StatefulWidget {
  final MeritRecord record;

  const AnimateText({super.key, required this.record});

  @override
  State<AnimateText> createState() => _AnimateTextState();
}

class _AnimateTextState extends State<AnimateText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacity;
  late Animation<Offset> position;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    opacity = Tween<double>(begin: 1, end: 0).animate(_controller);
    scale = Tween<double>(begin: 1, end: 0.9).animate(_controller);
    position = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.record.id != oldWidget.record.id) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
        position: position,
        child: FadeTransition(
            opacity: opacity, child: Text("功德+${widget.record.value}")),
      ),
    );
  }
}
