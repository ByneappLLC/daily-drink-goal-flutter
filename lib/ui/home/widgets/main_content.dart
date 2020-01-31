import 'package:daily_beer_goal_fl/ui/home/widgets/beer_level_progress.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/week_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainContent extends StatelessWidget {
  final Function onSettingsPressed;
  final Function onMenuPressed;

  const MainContent({Key key, this.onSettingsPressed, this.onMenuPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              FlutterConfig.get('APP_NAME').toUpperCase(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.alignLeft,
              color: Colors.black54,
            ),
            onPressed: onMenuPressed,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.cog,
                color: Colors.black54,
              ),
              onPressed: onSettingsPressed,
            )
          ],
        ),
        Body()
      ],
    );
  }
}

class Body extends StatelessWidget {
  _target(String text, String value) {
    return Row(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black54),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              child: BeerLevelProgress(),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _target('Current:', '16L'),
                  _target('Desired:', '20L')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              height: 2,
              color: Colors.black26,
            ),
            SizedBox(
              height: 50,
            ),
            WeekChart(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
