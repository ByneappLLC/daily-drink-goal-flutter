import 'package:flutter/widgets.dart';
import 'dart:math';

class AddScreenAnimator {
  AddScreenAnimator(this.vsync) {
    flipController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 500));

    flipAnimation = Tween<double>(begin: 0.0, end: pi).animate(CurvedAnimation(
      parent: flipController,
      curve: Curves.easeIn,
    ));
  }

  final TickerProvider vsync;
  AnimationController flipController;
  Animation<double> flipAnimation;

  Future openSettings() async {
    try {
      await flipController.forward().orCancel;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  Future closeSettings() async {
    try {
      await flipController.reverse().orCancel;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  dispose() {
    flipController.dispose();
  }
}
