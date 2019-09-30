import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/springy_slider.dart';
import 'package:flutter/material.dart';

class BeerSlider extends StatelessWidget {
  final Function onSavePressed;

  const BeerSlider({Key key, this.onSavePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'GO GO GO!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: SpringySlider(
                    drinkingGoal: 1500,
                    percentDrank: 0.22,
                    markCount: 20,
                    onSpringStopped: (level) {
                      print('Current level: $level');
                    },
                    positiveColor: Colors.amber.shade400,
                    negativeColor: Colors.white),
              ),
              InkWell(
                onTap: onSavePressed,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'SAVE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
