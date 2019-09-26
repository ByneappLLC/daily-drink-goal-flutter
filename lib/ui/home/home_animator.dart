import 'package:flutter/widgets.dart';

class HomeScreenAnimator {
  HomeScreenAnimator(this.vsync) {
    drawerController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 300));

    translateRight = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        parent: drawerController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeInOutQuad));
    scaleDown = Tween(begin: 1.0, end: 0.8).animate(
        CurvedAnimation(parent: drawerController, curve: Curves.easeIn));
  }

  final TickerProvider vsync;
  AnimationController drawerController;
  Animation<double> translateRight;
  Animation<double> scaleDown;

  bool drawerIsOpen = false;

  Future openMenu() async {
    try {
      await drawerController.forward().orCancel;
      drawerIsOpen = true;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  Future closeMenu() async {
    try {
      await drawerController.reverse().orCancel;
      drawerIsOpen = false;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  dispose() {
    drawerController.dispose();
  }
}
