import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_controller.dart';
import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_state.dart';
/**
 * Codes for stringy widgets and all corresponding widgets related to this
 * are taken from Fluttery UI Challenges 
 * (https://github.com/matthew-carroll/flutter_ui_challenge_springy_slider)
 * 
 * Matthew Carrol deleted his repository youtube channel :(
 */

import 'package:flutter/material.dart';

class SliderPoints extends StatelessWidget {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;
  final Color color;
  final int goal;

  SliderPoints(
      {this.sliderController,
      this.paddingTop,
      this.paddingBottom,
      this.color,
      this.goal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double sliderPercent = sliderController.sliderValue;
        if (sliderController.state == SpringySliderState.dragging) {
          sliderPercent = sliderController.draggingPercent.clamp(0.0, 1.0);
        }

        final height = constraints.maxHeight - paddingTop - paddingBottom;
        final sliderY = height * (1.0 - sliderPercent) + paddingTop;
        final pointsYouNeedPercent = 1.0 - sliderPercent;
        final pointsYouNeed = (goal * pointsYouNeedPercent).round();
        final pointsYouHavePercent = sliderPercent;
        final pointsYouHave = goal - pointsYouNeed;

        return Stack(
          children: <Widget>[
            Positioned(
              left: 30.0,
              top: sliderY - 10.0 - (40.0 * pointsYouNeedPercent),
              child: FractionalTranslation(
                translation: Offset(0.0, -1.0),
                child: Points(
                  goal: goal,
                  points: pointsYouNeed,
                  isAboveSlider: true,
                  isPointsYouNeed: true,
                  color: color,
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              top: sliderY + 10.0 + (40.0 * pointsYouHavePercent),
              child: Points(
                goal: goal,
                points: pointsYouHave,
                isAboveSlider: false,
                isPointsYouNeed: false,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class Points extends StatelessWidget {
  final int points;
  final bool isAboveSlider;
  final bool isPointsYouNeed;
  final Color color;
  final int goal;

  Points(
      {this.points,
      this.isAboveSlider = true,
      this.isPointsYouNeed = true,
      this.color,
      this.goal});

  @override
  Widget build(BuildContext context) {
    final percent = points / goal;
    final pointTextSize = 50.0 + (50.0 * percent);

    return Row(
      crossAxisAlignment:
          isAboveSlider ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        FractionalTranslation(
          translation: Offset(-0.05 * percent, isAboveSlider ? 0.18 : -0.18),
          child: Text(
            '$points',
            style: TextStyle(
              fontSize: pointTextSize,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'ml',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Text(
                isPointsYouNeed ? 'NEEDED' : 'DRANK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
