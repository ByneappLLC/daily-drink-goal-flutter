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

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
        lowerBound: 0.0,
        upperBound: widget.progress);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          _controller.reverse().then((_) => _controller.fling());
        },
        child: Container(
          color: Colors.transparent,
          height: constraints.maxHeight,
          width: 20,
          child: Column(
            children: <Widget>[
              Expanded(
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, snapshot) {
                      return CustomPaint(
                        painter: LinearPainter(
                          progress: _controller.value,
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
