import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_clipper.dart';
/**
 * Codes for stringy widgets and all corresponding widgets related to this
 * are taken from Fluttery UI Challenges 
 * (https://github.com/matthew-carroll/flutter_ui_challenge_springy_slider)
 * 
 * Matthew Carrol deleted his repository youtube channel :(
 */

import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_controller.dart';

import 'package:flutter/material.dart';

class SliderGoo extends StatelessWidget {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;
  final Widget child;

  SliderGoo({
    this.sliderController,
    this.paddingTop,
    this.paddingBottom,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SliderClipper(
        sliderController: sliderController,
        paddingTop: paddingTop,
        paddingBottom: paddingBottom,
      ),
      child: child,
    );
  }
}
