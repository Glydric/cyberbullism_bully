import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  final Widget child;

  const MyAnimation({required this.child, Key? key}) : super(key: key);

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration:  const Duration(milliseconds:300),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_animationController);

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _animation,
        child: widget.child,
      );
}
