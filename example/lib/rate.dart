import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class RateDemo extends StatefulWidget {
  @override
  _RateDemoState createState() => _RateDemoState();
}

class _RateDemoState extends State<RateDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Rate 评分')),
        body: Center(
          child: SyRate(
            value: 3,
            onTap: (v) {},
          ),
        ));
  }
}
