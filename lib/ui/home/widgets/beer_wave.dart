import 'dart:math';

import 'package:flutter/material.dart';

class BeerWave extends StatefulWidget {
  final double size;
  final Color fillColor;
  final double progress;
  final int frequency;

  const BeerWave(
      {Key key, this.size, this.fillColor, this.progress, this.frequency})
      : super(key: key);
  @override
  _BeerWaveState createState() => _BeerWaveState();
}

class _BeerWaveState extends State<BeerWave> with TickerProviderStateMixin {
  AnimationController waveController;
  AnimationController bubbleController;
  AnimationController heightController;
  Animation heightAnimation;
  Tween<double> heightTween;

  @override
  void initState() {
    super.initState();
    waveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    bubbleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 8500))
          ..addStatusListener(_bubbleStatusListener);

    heightController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    heightAnimation = CurvedAnimation(
      parent: Tween(begin: 0.0, end: 1.0).animate(heightController),
      curve: Curves.easeOutCubic,
    );

    heightTween = Tween(begin: 0.0, end: widget.progress);

    heightController.forward(from: 0.0);
    bubbleController.forward();
    waveController.repeat();
  }

  _bubbleStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      bubbleController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      bubbleController.forward();
    }
  }

  @override
  void dispose() {
    waveController.dispose();
    heightController.dispose();
    bubbleController.dispose();
    super.dispose();
  }

  void update(double progress) {
    setState(() {
      heightTween = Tween(
        begin: heightTween.evaluate(heightController),
        end: progress,
      );
      heightController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bubbles = List(20).map((_) {
      return RandomBubble(
        controller: bubbleController,
        waveHeight: widget.size * widget.progress,
        waveWidth: widget.size,
      );
    }).toList();
    final _beerWave = Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: waveController,
        builder: (context, _) {
          return CustomPaint(
            painter: WaveProgressPainter(heightTween.animate(heightAnimation),
                waveController, widget.fillColor, widget.frequency),
          );
        },
      ),
    );
    return Container(
      width: widget.size,
      height: widget.size,
      child: ClipPath(
        clipper: CircleClipper(),
        child: Stack(
          children: <Widget>[_beerWave, ...bubbles],
        ),
      ),
    );
  }
}

class WaveProgressPainter extends CustomPainter {
  Animation<double> _waveAnimation;
  Animation<double> _heightAnimation;
  Color fillColor;
  final int frequency;

  WaveProgressPainter(
    this._heightAnimation,
    this._waveAnimation,
    this.fillColor,
    this.frequency,
  ) : super(repaint: _waveAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    // draw small wave
    double p = _heightAnimation.value;
    double baseHeight = (1 - p) * size.height;

    Paint wave2Paint = Paint()..color = fillColor.withOpacity(0.5);

    double amp = 3.2;

    Path path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((_waveAnimation.value * 360 - i) % 360 * (pi / 180) * amp));
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, wave2Paint);

    // draw big wave
    Paint wave1Paint = Paint()..color = fillColor;

    amp = 2.1;

    path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          (baseHeight + 10) +
              sin((_waveAnimation.value * 360 - i) % 360 * (pi / 180) * amp));
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, wave1Paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RandomBubble extends StatefulWidget {
  final double waveWidth;
  final double waveHeight;
  final AnimationController controller;

  static const POSITIONED = 1;

  RandomBubble({Key key, this.waveHeight, this.waveWidth, this.controller})
      : super(key: key);

  @override
  _RandomBubbleState createState() => _RandomBubbleState();
}

class _RandomBubbleState extends State<RandomBubble> {
  final _random = Random();

  int _next(int max) => _random.nextInt(max);

  int _nextType() => _random.nextInt(3);

  double _nextWidth() => 4 + _random.nextInt(10 - 4).toDouble();

  double _nextHeight() => 4 + _random.nextInt(10 - 4).toDouble();

  double _nextAnimatedValue() => _random.nextDouble();

  double _posBottom;
  double _posLeft;
  bool _isPositioned;
  Animation _anim;
  Widget _bubble;

  _buildStaticVanishingBubble() => ScaleTransition(
        alignment: Alignment.center,
        scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.controller,
            curve: Interval(_nextAnimatedValue(), 1.0,
                curve: Curves.fastOutSlowIn))),
        child: Container(
          width: _nextWidth(),
          height: _nextHeight(),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        ),
      );

  double _nextMovementUpper() =>
      (widget.waveHeight / 2) +
      _random
          .nextInt((widget.waveHeight - (widget.waveHeight / 2)).toInt())
          .toDouble();

  _buildMovingBubble(Animation animation, double size) => AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        return Transform(
          transform: Matrix4.translationValues(0.0, animation.value, 0.0),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                  animation.status == AnimationStatus.reverse ? 0.0 : 0.4),
              shape: BoxShape.circle,
            ),
          ),
        );
      });

  @override
  void initState() {
    super.initState();
    _posBottom = _next(widget.waveHeight.toInt()).toDouble();
    _posLeft = _next(widget.waveWidth.toInt()).toDouble();
    _isPositioned = _nextType() == RandomBubble.POSITIONED;
    if (!_isPositioned) {
      _anim = Tween(begin: _nextMovementUpper(), end: -widget.waveHeight)
          .animate(CurvedAnimation(
        parent: widget.controller,
        curve: Curves.linear,
      ));
    }
    if (_isPositioned) {
      _bubble = _buildStaticVanishingBubble();
    } else {
      _bubble = _buildMovingBubble(_anim, _nextWidth());

      _anim.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.reverse) {
          setState(() {
            _posBottom = _next(widget.waveHeight.toInt()).toDouble();
            _posLeft = _next(widget.waveWidth.toInt()).toDouble();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _posBottom,
      left: _posLeft,
      child: _bubble,
    );
  }
}
