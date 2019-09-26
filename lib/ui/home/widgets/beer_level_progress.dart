import 'package:daily_beer_goal_fl/ui/home/widgets/beer_wave.dart';
import 'package:daily_beer_goal_fl/ui/widgets/tiltable_stack.dart';
import 'package:flutter/material.dart';

class BeerLevelProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return TiltableStack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox.fromSize(
              key: ValueKey('wave'),
              size: Size.square(constraints.maxWidth * 3 / 4 - 20),
              child: Material(
                elevation: 4,
                shape: CircleBorder(),
                child: BeerWave(
                  size: constraints.maxWidth * 2 / 3,
                  progress: 0.76,
                  fillColor: Colors.amber.shade300,
                  frequency: 1,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'LEVEL',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  '12',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
