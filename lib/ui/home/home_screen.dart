import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/ui/home/home_animator.dart';
import 'package:daily_beer_goal_fl/ui/home/settings/settings_card.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/drawer_menu.dart';
import 'package:daily_beer_goal_fl/ui/home/widgets/main_animated_content.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

final _container = kiwi.Container();

BeersBloc _blocInstance;

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  static PageRoute newInstance() {
    if (_blocInstance == null) {
      _blocInstance = _container<BeersBloc>();
    }

    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              bloc: _blocInstance,
              child: HomeScreen(),
            ));
  }

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
          } else if (_animator.settingsIsOpen) {
            _animator.closeSettings();
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
            Positioned(
              top: 0,
              right: 0,
              child: SettingsCard(
                animator: _animator,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animator.dispose();
    _blocInstance = null;
  }
}
