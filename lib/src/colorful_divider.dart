import 'package:flutter/material.dart';

class SyColorfulDivider extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops; //每个颜色相对应的线段长度

  /// same as [Canvas.skew] the horizontal skew in radians clockwise around the origin
  final double skewX;

  SyColorfulDivider({Key? key, required this.colors, required this.stops, this.skewX = -1})
      : assert(stops.every((double stop) => stop >= 0)),
        assert(colors.length == stops.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: new _ColorfulPainter(
        colors: colors,
        stops: stops,
        skewX: skewX,
      ),
    );
  }
}

class _ColorfulPainter extends CustomPainter {
  final List<Color>? colors;
  final List<double>? stops;
  final double? skewX;

  const _ColorfulPainter({this.colors, this.stops, this.skewX});

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height > 0, 'SyColorfulDivider: height must > 0');
    assert(size.width > 0, 'SyColorfulDivider: width must > 0');
    List<Paint> paints = [];
    for (Color color in colors!) {
      Paint paint = Paint()
        ..color = color
        ..strokeWidth = size.height;
      paints.add(paint);
    }

    Rect rect = Offset.zero & size;
    canvas.clipRect(rect);

    canvas.translate(-stops![0] / 2, size.height / 2);
    canvas.skew(skewX!, 0);

    int i = 0;
    double totalWidth = 0;
    while (true) {
      if (totalWidth >= size.width + stops![0]) {
        break;
      }
      final Paint paint = paints[i % colors!.length];
      final itemWidth = stops![i % stops!.length];
      canvas.drawLine(
        Offset(totalWidth, 0),
        Offset(totalWidth + itemWidth, 0),
        paint,
      );
      totalWidth += itemWidth;
      i++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
