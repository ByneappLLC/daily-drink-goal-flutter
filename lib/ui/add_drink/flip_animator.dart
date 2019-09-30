import 'package:flutter/widgets.dart';
import 'dart:math';

class FlipAnimator {
  FlipAnimator(this.vsync) {
    flipController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 300));

    flipA = Tween<double>(begin: 0.0, end: pi / 2).animate(CurvedAnimation(
      parent: flipController,
      curve: Interval(0, 0.5, curve: Curves.easeIn),
    ));
    flipB = Tween<double>(begin: pi / 2, end: pi).animate(CurvedAnimation(
      parent: flipController,
      curve: Interval(0.5, 1, curve: Curves.easeIn),
    ));
  }

  final TickerProvider vsync;
  AnimationController flipController;
  Animation<double> flipA;
  Animation<double> flipB;

  bool flipped = false;

  Future flip() async {
    try {
      if (flipped) {
        await flipController.reverse().orCancel;
        flipped = false;
      } else {
        await flipController.forward().orCancel;
        flipped = true;
      }
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  dispose() {
    flipController.dispose();
  }
}
