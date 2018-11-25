import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class ColorfulDividerDemo extends StatefulWidget {
  @override
  _ColorfulDividerDemoState createState() => _ColorfulDividerDemoState();
}

class _ColorfulDividerDemoState extends State<ColorfulDividerDemo> {
  final List<Color> _colors = [
    Colors.red,
    Colors.white,
    Colors.blue,
    Colors.white,
  ];
  final List<double> _stops = [
    40,
    20,
    40,
    20,
  ];
  @override
  Widget build(BuildContext context) {
    const _divider = SizedBox(
      height: 40.0,
    );

    return Scaffold(
        appBar: AppBar(title: Text('colorful divider demo')),
        body: ListView(
          children: <Widget>[
            _divider,
            SizedBox(
              height: 4.0,
              child: SyColorfulDivider(
                colors: _colors,
                stops: _stops,
              ),
            ),
            _divider,
            SizedBox(
              height: 8.0,
              child: SyColorfulDivider(
                colors: _colors,
                stops: _stops,
                skewX: 0,
              ),
            ),
            _divider,
            SizedBox(
              height: 8.0,
              child: SyColorfulDivider(
                colors: _colors,
                stops: _stops,
                skewX: 1,
              ),
            ),
          ],
        ));
  }
}
