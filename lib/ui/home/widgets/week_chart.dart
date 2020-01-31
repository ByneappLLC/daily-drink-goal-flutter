import 'package:daily_beer_goal_fl/core/base_bloc.dart';
import 'package:daily_beer_goal_fl/data/models/week_data.dart';
import 'package:daily_beer_goal_fl/feature/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/day_progress.dart';
import 'package:flutter/material.dart';

class WeekChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<BeersBloc>(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        height: 250,
        child: StreamBuilder<List<WeekData>>(
          stream: _bloc.streams.weeklyDrinks,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: snapshot.data
                    .map((d) => DayProgress(
                          data: d,
                        ))
                    .toList(),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
