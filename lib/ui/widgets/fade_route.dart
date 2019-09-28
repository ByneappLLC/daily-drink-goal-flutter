import 'package:flutter/material.dart';

class FadeRoute<T> extends PageRoute<T> {
  FadeRoute(this.builder, {this.fadeDuration = 400});
  final WidgetBuilder builder;
  final int fadeDuration;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: fadeDuration);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => null;
}
