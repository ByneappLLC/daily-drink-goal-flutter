import 'package:daily_beer_goal_fl/data/models/week_data.dart';
import 'package:daily_beer_goal_fl/ui/widgets/linear_painter.dart';
import 'package:flutter/material.dart';

class DayProgress extends StatefulWidget {
  final WeekData data;

  const DayProgress({Key key, this.data}) : super(key: key);

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

    update(widget.data.progress);

    super.initState();
  }

  void update(double progress) {
    _animation = Tween<double>(begin: 0.0, end: widget.data.progress).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInOutQuad));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_animation.value != widget.data.progress) {
      update(widget.data.progress);
    }
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
                          progressColor: Colors.amber.shade300,
                          backgroundColor: Colors.grey.shade300,
                          lineWidth: 14,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.data.day,
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
