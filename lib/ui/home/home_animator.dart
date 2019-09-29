import 'package:flutter/widgets.dart';

class HomeScreenAnimator {
  HomeScreenAnimator(this.vsync) {
    drawerController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 300));

    settingsController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 500));

    translateRight = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        parent: drawerController,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInCirc));
    scaleDown = Tween(begin: 1.0, end: 0.8).animate(
        CurvedAnimation(parent: drawerController, curve: Curves.easeIn));

    rotateIn = Tween(begin: 1.7, end: 0.0).animate(CurvedAnimation(
        parent: settingsController,
        curve: Curves.elasticInOut,
        reverseCurve: Curves.easeInCirc));
  }

  final TickerProvider vsync;
  AnimationController drawerController;
  AnimationController settingsController;
  Animation<double> translateRight;
  Animation<double> scaleDown;
  Animation<double> rotateIn;

  bool drawerIsOpen = false;
  bool settingsIsOpen = false;

  Future openMenu() async {
    if (settingsIsOpen) {
      closeSettings();
    }
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

  Future openSettings() async {
    try {
      await settingsController.forward().orCancel;
      settingsIsOpen = true;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  Future closeSettings() async {
    try {
      await settingsController.reverse().orCancel;
      settingsIsOpen = false;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  dispose() {
    drawerController.dispose();
    settingsController.dispose();
  }
}
