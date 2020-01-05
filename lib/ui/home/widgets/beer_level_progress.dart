import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/beer_wave.dart';
import 'package:daily_beer_goal_fl/ui/widgets/tiltable_stack.dart';
import 'package:flutter/material.dart';

class BeerLevelProgress extends StatefulWidget {
  @override
  _BeerLevelProgressState createState() => _BeerLevelProgressState();
}

class _BeerLevelProgressState extends State<BeerLevelProgress> {
  GlobalKey<BeerWaveState> waveKey = GlobalKey();
  BeersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BeersBloc>(context);
    print('Initialized bloc on beer level widget');
    _bloc.streams.drinkingProgress.listen((p) {
      waveKey.currentState?.update(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    final layout = LayoutBuilder(
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
                  key: waveKey,
                  size: constraints.maxWidth * 2 / 3,
                  progress: 0.01,
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

    if (isPortrait) {
      return layout;
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: layout,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text('A Beer A Day Keeps the Doctors away'),
              ),
            ),
          )
        ],
      );
    }
  }
}
