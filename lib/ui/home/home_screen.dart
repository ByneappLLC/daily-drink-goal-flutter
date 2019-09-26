import 'package:daily_beer_goal_fl/ui/home/home_animator.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/drawer_menu.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/main_animated_content.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  static PageRoute newInstance() =>
      MaterialPageRoute(builder: (context) => HomeScreen());
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeScreenAnimator _animator;

  @override
  void initState() {
    _animator = HomeScreenAnimator(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_animator.drawerIsOpen) {
            _animator.closeMenu();
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
              left: 0,
              child: DrawerMenu(
                onPress: _animator.openMenu,
                onDrinkPress: _animator.closeMenu,
              ),
            ),
            MainAnimatedContent(
              animator: _animator,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animator.dispose();
  }
}
