import 'package:daily_beer_goal_fl/ui/home/home_animator.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/drawer_menu.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/main_content.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  static PageRoute newInstance() =>
      MaterialPageRoute(builder: (context) => HomeScreen());
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  HomeScreenAnimator _animator;
  bool _drawerIsOpen = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animator = HomeScreenAnimator(_controller);
    super.initState();
  }

  _mainContent() => AnimatedBuilder(
      animation: _controller,
      child: MainContent(
        onMenuPressed: _openMenu,
        onSettingsPressed: _closeMenu,
      ),
      builder: (context, widget) => Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.translationValues(
                _animator.translateRight.value, 0.0, 0.0)
              ..scale(_animator.scaleDown.value),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 30, spreadRadius: 20, color: Colors.black12)
                  ],
                ),
                child: _drawerIsOpen
                    ? Stack(
                        children: <Widget>[
                          widget,
                          GestureDetector(
                            child: Container(
                              color: Colors.transparent,
                            ),
                            onTap: _closeMenu,
                          )
                        ],
                      )
                    : widget),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_drawerIsOpen) {
            _closeMenu();
            return false;
          } else {
            return true;
          }
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              top: 0,
              left: 30,
              child: DrawerMenu(
                onPress: _closeMenu,
              ),
            ),
            _mainContent()
          ],
        ),
      ),
    );
  }

  Future _openMenu() async {
    try {
      await _controller.forward().orCancel;
      _drawerIsOpen = true;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }

  Future _closeMenu() async {
    try {
      await _controller.reverse().orCancel;
      _drawerIsOpen = false;
    } on TickerCanceled {
      print("Animation Failed");
    }
  }
}
