import 'dart:math';

import 'package:daily_beer_goal_fl/ui/add_drink/add_screen_animator.dart';
import 'package:daily_beer_goal_fl/ui/add_drink/beer_slider.dart';
import 'package:daily_beer_goal_fl/ui/add_drink/flip_animator.dart';
import 'package:daily_beer_goal_fl/ui/widgets/fade_route.dart';
import 'package:flutter/material.dart';

class AddDrinkScreen extends StatefulWidget {
  static const routeName = 'addDrinkScreen';

  static PageRoute newInstance() => FadeRoute((c) => AddDrinkScreen());

  @override
  _AddDrinkScreenState createState() => _AddDrinkScreenState();
}

class _AddDrinkScreenState extends State<AddDrinkScreen>
    with TickerProviderStateMixin {
  FlipAnimator _animator;

  @override
  void initState() {
    _animator = FlipAnimator(this);
    super.initState();
  }

  Matrix4 _pMatrix(num pValue) => Matrix4(
        1.0, 0.0, 0.0, 0.0, //
        0.0, 1.0, 0.0, 0.0, //
        0.0, 0.0, 1.0, pValue * 0.001, //
        0.0, 0.0, 1.0, 1.0,
      );

  @override
  Widget build(BuildContext context) {
    final sideA = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: _animator.flip,
        child: Material(
          color: Colors.transparent,
          child: Container(
            child: Center(
              child: Text('Page 1'),
            ),
          ),
        ),
      ),
    );
    final sideB = Transform(
      transform: Matrix4.identity()..rotateY(pi),
      alignment: FractionalOffset.center,
      child: BeerSlider(
        onSavePressed: _animator.flip,
      ),
    );
    final stack = Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _animator.flipA,
          child: sideA,
          builder: (context, widget) {
            return Transform(
              transform: _pMatrix(1.0)..rotateY(_animator.flipA.value),
              child: widget,
              alignment: FractionalOffset.center,
            );
          },
        ),
        AnimatedBuilder(
          animation: _animator.flipB,
          child: sideB,
          builder: (context, widget) {
            return Transform(
              transform: _pMatrix(1.0)..rotateY(_animator.flipB.value),
              child: widget,
              alignment: FractionalOffset.center,
            );
          },
        ),
      ],
    );
    return Hero(
      tag: 'fab-to-add',
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: stack,
      ),
    );
  }
}
