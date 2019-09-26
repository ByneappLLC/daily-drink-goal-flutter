import 'package:daily_beer_goal_fl/ui/widgets/linear_painter.dart';
import 'package:flutter/material.dart';

class DayProgress extends StatefulWidget {
  final double progress;

  const DayProgress({Key key, this.progress}) : super(key: key);

  @override
  _DayProgressState createState() => _DayProgressState();
}

class _DayProgressState extends State<DayProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _animation = Tween(begin: 0.0, end: widget.progress).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInOutQuad));
    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          _controller.reverse().then((_) => _controller.forward());
        },
        child: Container(
          color: Colors.transparent,
          height: constraints.maxHeight,
          width: 20,
          child: Column(
            children: <Widget>[
              Expanded(
                child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, snapshot) {
                      return CustomPaint(
                        painter: LinearPainter(
                          progress: _animation.value,
                          progressColor: Colors.yellow,
                          backgroundColor: Colors.grey,
                          lineWidth: 14,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'H',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
