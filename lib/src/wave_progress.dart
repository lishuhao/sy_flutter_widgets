import 'dart:ui';

import 'package:flutter/material.dart';

class SyWaveProgress extends StatefulWidget {
  final double percent; //进度 0 ～ 1
  final Color primaryColor; //主色
  final Color secondaryColor; //次色调

  const SyWaveProgress({
    Key? key,
    required this.percent,
    required this.primaryColor,
    required this.secondaryColor,
  })   : assert(percent >= 0 && percent <= 1.0),
        super(key: key);
  @override
  _SyWaveProgressState createState() => _SyWaveProgressState();
}

class _SyWaveProgressState extends State<SyWaveProgress>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _heightController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _waveController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _waveController.addListener(() {
      setState(() {});
    });
    _waveController.forward();
    _waveController.repeat();

    _heightController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _heightAnimation =
        Tween(begin: 0.0, end: widget.percent).animate(_heightController)
          ..addListener(() {
            setState(() {});
          });
    _heightController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(
        percent: _heightAnimation.value,
        offsetPercent: _waveController.value,
        primaryColor: widget.primaryColor,
        secondaryColor: widget.secondaryColor,
      ),
      size: Size.infinite,
      isComplex: true,
      child: Center(
        child: Text(
          '${(_heightAnimation.value * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent; //0~1
  final double offsetPercent;
  final Color? primaryColor;
  final Color? secondaryColor;

  MyPainter(
      {required this.percent,
      this.primaryColor,
      this.secondaryColor,
      required this.offsetPercent})
      : assert(percent >= 0 && percent <= 1, 'percent:0~1'),
        assert(offsetPercent >= 0 && offsetPercent <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    final canvasWidth = size.width;
    final offset = canvasWidth * (1 - offsetPercent);
    final offset2 = canvasWidth * offsetPercent;
    _drawWave(canvas, size, offset, secondaryColor!);
    _drawWave(canvas, size, offset2, primaryColor!);

    canvas.drawCircle(Offset(canvasWidth / 2, canvasWidth / 2), canvasWidth / 2,
        Paint()..style = PaintingStyle.stroke);
  }

  _drawWave(Canvas canvas, Size size, double offset, Color color) {
    Rect rect = Offset.zero & size;
    final canvasWidth = size.width;
    final waveHeight = canvasWidth * (1 - percent);
    final amplitude = canvasWidth / 10; //振幅
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0 - offset, waveHeight);
    path.quadraticBezierTo(canvasWidth / 4 - offset, waveHeight - amplitude,
        canvasWidth / 2 - offset, waveHeight);

    path.quadraticBezierTo(canvasWidth * 3 / 4 - offset, waveHeight + amplitude,
        canvasWidth - offset, waveHeight);

    path.quadraticBezierTo(
        canvasWidth / 4 - offset + canvasWidth,
        waveHeight - amplitude,
        canvasWidth / 2 - offset + canvasWidth,
        waveHeight);

    path.quadraticBezierTo(canvasWidth * 3 / 4 - offset + canvasWidth,
        waveHeight + amplitude, canvasWidth - offset + canvasWidth, waveHeight);

    path.lineTo(canvasWidth - offset + canvasWidth, canvasWidth);
    path.lineTo(0 - offset, canvasWidth);
    path.close();
    canvas.clipRRect(
        new RRect.fromRectXY(rect, canvasWidth / 2, canvasWidth / 2));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
