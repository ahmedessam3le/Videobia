import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  final Widget child;
  CircleAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    animationController.forward();
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
      child: widget.child,
    );
  }
}