import 'dart:math' as math;

import 'package:flutter/material.dart';

class SyCircleProgress extends StatefulWidget {
  final double progress; //进度 0～1
  final Color primaryColor; //进度条主色
  final Color secondaryColor; //进度条背景色
  final double strokeWidth; //进度条宽度

  const SyCircleProgress(
      {Key key,
      @required this.progress,
      @required this.primaryColor,
      @required this.secondaryColor,
      this.strokeWidth = 10.0})
      : assert(progress >= 0 && progress <= 1),
        super(key: key);

  @override
  _SyCircleProgressState createState() => _SyCircleProgressState();
}

class _SyCircleProgressState extends State<SyCircleProgress>
    with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: 1),
        upperBound: widget.progress,
        vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircleProgressPainter(_controller.value, widget.primaryColor,
          widget.secondaryColor, widget.strokeWidth),
      child: Center(
        child: Text(
          '${(_controller.value * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final progress;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokeWidth;

  _CircleProgressPainter(
      this.progress, this.primaryColor, this.secondaryColor, this.strokeWidth)
      : assert(progress >= 0 && progress <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    final canvasWidth = size.width > size.height ? size.height : size.width;
    final center = Offset(size.width / 2, size.height / 2);
    final primaryStrokeWidth = strokeWidth;
    final secondaryStrokeWidth = strokeWidth;
    final radius = canvasWidth / 2 - secondaryStrokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final primaryPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = primaryStrokeWidth
      ..strokeCap = StrokeCap.round
      ..color = primaryColor;

    final secondaryPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = secondaryStrokeWidth;
    canvas.drawCircle(center, radius, secondaryPaint);

    Path path = Path();
    path.arcTo(rect, -math.pi / 2, 2 * math.pi * progress, false);
    canvas.drawPath(path, primaryPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
