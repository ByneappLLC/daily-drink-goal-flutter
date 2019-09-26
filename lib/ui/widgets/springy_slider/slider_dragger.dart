/**
 * Codes for stringy widgets and all corresponding widgets related to this
 * are taken from Fluttery UI Challenges 
 * (https://github.com/matthew-carroll/flutter_ui_challenge_springy_slider)
 * 
 * Matthew Carrol deleted his repository youtube channel :(
 */

import 'package:daily_beer_goal_fl/ui/widgets/springy_slider/slider_controller.dart';

import 'package:flutter/material.dart';

class SliderDragger extends StatefulWidget {
  final SpringySliderController sliderController;
  final double paddingTop;
  final double paddingBottom;
  final Widget child;

  SliderDragger({
    this.sliderController,
    this.paddingTop,
    this.paddingBottom,
    this.child,
  });

  @override
  _SliderDraggerState createState() => _SliderDraggerState();
}

class _SliderDraggerState extends State<SliderDragger> {
  double startDragY;
  double startDragPercent;

  void _onPanStart(DragStartDetails details) {
    startDragY = details.globalPosition.dy;
    startDragPercent = widget.sliderController.sliderValue;

    final sliderWidth = context.size.width;
    final sliderLeftPosition = (context.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0))
        .dx;
    final dragHorizontalPercent =
        (details.globalPosition.dx - sliderLeftPosition) / sliderWidth;

    widget.sliderController.onDragStart(dragHorizontalPercent);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final dragDistance = startDragY - details.globalPosition.dy;
    final sliderHeight =
        context.size.height - widget.paddingTop - widget.paddingBottom;
    final dragPercent = dragDistance / sliderHeight;

    final sliderWidth = context.size.width;
    final sliderLeftPosition = (context.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0))
        .dx;
    final dragHorizontalPercent =
        (details.globalPosition.dx - sliderLeftPosition) / sliderWidth;

    widget.sliderController.draggingPercents = new Offset(
      dragHorizontalPercent,
      startDragPercent + dragPercent,
    );
  }

  void _onPanEnd(DragEndDetails details) {
    startDragY = null;
    startDragPercent = null;

    widget.sliderController.onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: widget.child,
    );
  }
}
