import 'package:flutter/widgets.dart';

class HomeScreenAnimator {
  HomeScreenAnimator(this.controller)
      : translateRight = Tween(begin: 0.0, end: 200.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInCubic)),
        scaleDown = Tween(begin: 1.0, end: 0.8)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

  final AnimationController controller;
  final Animation<double> translateRight;
  final Animation<double> scaleDown;
}
