import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/ui/home/home_animator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsCard extends StatelessWidget {
  final HomeScreenAnimator animator;

  const SettingsCard({Key key, this.animator}) : super(key: key);

  _settingsSelection(String text, Function onPress, IconData icon) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black54,
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _bloc = BlocProvider.of<BeersBloc>(context);
    return AnimatedBuilder(
      animation: animator.settingsController,
      builder: (context, widget) {
        return Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.identity()..rotateZ(animator.rotateIn.value),
          child: GestureDetector(
            onTap: animator.closeSettings,
            child: Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height,
              child: Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.5,
                    bottom: size.height * 0.65,
                    top: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-30, 0),
                        blurRadius: 50,
                        spreadRadius: 20,
                        color: Colors.black12)
                  ],
                ),
                child: SafeArea(
                  top: true,
                  bottom: true,
                  left: true,
                  right: false,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _settingsSelection('Delete All', _bloc.deleteAll,
                              FontAwesomeIcons.userAlt),
                          _settingsSelection(
                              'Set Goal', () {}, FontAwesomeIcons.trophy)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
