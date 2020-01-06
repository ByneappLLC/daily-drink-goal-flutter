/**
 * Codes for stringy widgets and all corresponding widgets related to this
 * are taken from Fluttery UI Challenges
 * (https://github.com/matthew-carroll/flutter_ui_challenge_springy_slider)
 *
 * Matthew Carrol deleted his repository youtube channel :(
 */

import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_controller.dart';
import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_dragger.dart';
import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_goo.dart';
import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_marks.dart';
import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_points.dart';
import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_state.dart';
import 'package:flutter/material.dart';

class SpringySlider extends StatefulWidget {
  final int markCount;
  final Color positiveColor;
  final Color negativeColor;
  final int drinkingGoal;
  final double percentDrank;
  final Function(double) onSpringStopped;

  SpringySlider(
      {this.markCount,
      this.positiveColor,
      this.negativeColor,
      this.percentDrank,
      this.onSpringStopped,
      this.drinkingGoal});

  @override
  _SpringySliderState createState() => new _SpringySliderState();
}

class _SpringySliderState extends State<SpringySlider>
    with TickerProviderStateMixin {
  final double paddingTop = 50.0;
  final double paddingBottom = 50.0;

  SpringySliderController sliderController;

  @override
  void initState() {
    super.initState();
    sliderController = SpringySliderController(
      sliderPercent: widget.percentDrank,
      vsync: this,
    )..addListener(() {
        setState(() {});
        if (sliderController.state == SpringySliderState.idle) {
          if (widget.onSpringStopped != null) {
            final current = sliderController.sliderValue * widget.drinkingGoal;

            widget.onSpringStopped(current);
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // double sliderPercent = sliderController.sliderValue;
    // if (sliderController.state == SpringySliderState.springing) {
    //   sliderPercent = sliderController.springingPercent;
    // }

    return SliderDragger(
      sliderController: sliderController,
      paddingTop: paddingTop,
      paddingBottom: paddingBottom,
      child: Stack(
        children: <Widget>[
          SliderMarks(
            markCount: widget.markCount,
            markColor: widget.positiveColor,
            backgroundColor: widget.negativeColor,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
          ),
          SliderGoo(
            sliderController: sliderController,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
            child: SliderMarks(
              markCount: widget.markCount,
              markColor: widget.negativeColor,
              backgroundColor: widget.positiveColor,
              paddingTop: paddingTop,
              paddingBottom: paddingBottom,
            ),
          ),
          SliderPoints(
            sliderController: sliderController,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
            color: widget.positiveColor,
            goal: widget.drinkingGoal,
          ),
          // SliderDebug(
          //   sliderPercent: sliderController.state == SpringySliderState.dragging
          //       ? sliderController.draggingPercent
          //       : sliderPercent,
          //   paddingTop: paddingTop,
          //   paddingBottom: paddingBottom,
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    sliderController.dispose();
    super.dispose();
  }
}
