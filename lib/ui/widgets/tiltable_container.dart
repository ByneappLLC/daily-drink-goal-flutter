import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';

class TiltableContainer extends StatefulWidget {
  final Widget child;
  final Alignment alignment;
  final bool disabled;
  final Function onTap;

  const TiltableContainer({
    Key key,
    @required this.child,
    this.disabled = false,
    this.onTap,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  _TiltableContainerState createState() => _TiltableContainerState();
}

class _TiltableContainerState extends State<TiltableContainer>
    with TickerProviderStateMixin {
  AnimationController tilt;
  AnimationController depth;
  double pitch = 0;
  double yaw = 0;
  Offset _offset;
  SpringSimulation springSimulation;
  PublishSubject<bool> stream = PublishSubject();

  @override
  void initState() {
    super.initState();
    tilt = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 500),
      vsync: this,
      lowerBound: -2,
      upperBound: 2,
    )..addListener(() {
        if (_offset == null) {
          pitch *= tilt.value;
          yaw *= tilt.value;
          updateTransformation();
        }
      });
    depth = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 500),
      vsync: this,
      lowerBound: -2,
      upperBound: 2,
    )..addListener(updateTransformation);
  }

  @override
  dispose() {
    tilt.dispose();
    depth.dispose();
    stream.close();
    super.dispose();
  }

  updateTransformation() {
    stream.add(true);
  }

  SpringDescription spring =
      SpringDescription(mass: 1, stiffness: 400, damping: 6);

  cancelPan() {
    tilt.animateWith(SpringSimulation(spring, 1, 0, tilt.velocity));
    depth.animateWith(SpringSimulation(spring, depth.value, 0, depth.velocity));
    _offset = null;
  }

  startPan() {
    depth.animateWith(SpringSimulation(spring, depth.value, 1, depth.velocity));
  }

  updatePan(LongPressMoveUpdateDetails drag) {
    var size = MediaQuery.of(context).size;
    var offset = _globalToLocal(context, drag.globalPosition);
    if (_offset == null) {
      _offset = offset;
    }

    pitch += (offset.dy - _offset.dy) * (1 / size.height);
    yaw -= (offset.dx - _offset.dx) * (1 / size.width);
    _offset = offset;

    updateTransformation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressMoveUpdate: widget.disabled ? (_) {} : updatePan,
      onLongPressStart: (_) => widget.disabled ? () {} : startPan(),
      onLongPressEnd: (_) => widget.disabled ? () {} : cancelPan(),
      onTapDown: (_) => widget.disabled
          ? () {}
          : depth.animateWith(SpringSimulation(spring, depth.value, 0, -5)),
      child: StreamBuilder<bool>(
        stream: stream.stream,
        builder: (context, snap) => TiltedContainer(
          data: TransformationData(pitch, yaw, depth.value),
          alignment: widget.alignment,
          child: Stack(
            children: <Widget>[
              widget.child,
              if (!widget.disabled)
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                  ),
                  onTap: widget.onTap,
                )
            ],
          ),
        ),
      ),
    );
  }

  Offset _globalToLocal(BuildContext context, Offset globalPosition) {
    final RenderBox box = context.findRenderObject();
    return box.globalToLocal(globalPosition);
  }
}

class TransformationData {
  final double pitch;
  final double yaw;
  final double depth;

  TransformationData(this.pitch, this.yaw, this.depth);
}

class TiltedContainer extends StatelessWidget {
  final TransformationData data;
  final Widget child;
  final AlignmentGeometry alignment;

  const TiltedContainer({Key key, this.data, this.alignment, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = 0;
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(data.pitch)
        ..rotateY(data.yaw)
        ..translate(-data.yaw * index * 70, data.pitch * index * 70, 0)
        ..scale((data.depth ?? 0) * (index + 1) * 0.1 + 1),
      child: child,
      alignment: FractionalOffset.center,
    );
  }
}
