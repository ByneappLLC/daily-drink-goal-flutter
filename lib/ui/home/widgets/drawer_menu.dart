import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  final Function onPress;

  const DrawerMenu({Key key, this.onPress}) : super(key: key);

  Widget _button(Function onPressed, String title, IconData icon) => FlatButton(
        color: Colors.yellow.shade200,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              icon,
              color: Colors.black54,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _button(() {}, "Drink", FontAwesomeIcons.accessibleIcon),
          _button(() {}, 'Drink', Icons.account_balance_wallet),
          _button(() {}, 'Get Help', Icons.child_friendly),
        ],
      ),
    );
  }
}
