import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  final Function onPress;
  final Function onDrinkPress;

  const DrawerMenu({Key key, this.onPress, this.onDrinkPress})
      : super(key: key);

  Widget _button(Function onPressed, String title, IconData icon) => FlatButton(
        color: Colors.amberAccent.shade200,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
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
      width: 135,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _button(onDrinkPress, "Drink", FontAwesomeIcons.glassCheers),
          SizedBox(
            height: 15,
          ),
          Banner(
            message: 'Comming Soon',
            location: BannerLocation.topEnd,
            child: _button(() {}, 'Leaders', FontAwesomeIcons.trophy),
          ),
          SizedBox(
            height: 15,
          ),
          _button(() {}, 'Contact', FontAwesomeIcons.mobileAlt),
          SizedBox(
            height: 15,
          ),
          _button(() {}, 'Get Help', FontAwesomeIcons.handsHelping),
        ],
      ),
    );
  }
}
