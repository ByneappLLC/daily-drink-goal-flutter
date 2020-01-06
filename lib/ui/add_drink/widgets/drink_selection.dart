import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrinkSelection extends StatelessWidget {
  final Function onMoreSelected;
  final Function(double) onAmountSelected;

  const DrinkSelection(
      {Key key, @required this.onMoreSelected, @required this.onAmountSelected})
      : super(key: key);

  _selection(Function onPress, String text, Widget icon,
          BorderRadiusGeometry borderRadius) =>
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: borderRadius, color: Colors.grey.shade800),
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.transparent,
            child: InkWell(
              onTap: onPress,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style:
                          TextStyle(fontSize: 18, color: Colors.amber.shade400),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          _selection(
            () => onAmountSelected(350),
            'Can/Small Bottle (350ml)',
            Icon(
              Icons.local_drink,
              color: Colors.amber.shade400,
              size: 30,
            ),
            BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20)),
          ),
          _selection(
            () => onAmountSelected(550),
            'Large Bottle (550ml)',
            Icon(
              FontAwesomeIcons.wineBottle,
              color: Colors.amber.shade400,
              size: 30,
            ),
            null,
          ),
          _selection(
              onMoreSelected,
              'Manual Entry',
              Icon(
                Icons.more_horiz,
                color: Colors.amber.shade400,
                size: 30,
              ),
              BorderRadius.only(
                  bottomRight: const Radius.circular(20),
                  bottomLeft: const Radius.circular(20))),
        ],
      ),
    );
  }
}
