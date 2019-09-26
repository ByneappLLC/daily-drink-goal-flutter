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
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.yellow,
              height: 300,
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _target('Current:', '16L'),
                _target('Desired:', '20L')
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 2,
              color: Colors.black26,
            ),
            Container(
              height: 500,
            )
          ],
        ),
      ),
    );
  }
}
