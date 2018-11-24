import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class WaveProgressDemo extends StatefulWidget {
  @override
  _WaveProgressDemoState createState() => _WaveProgressDemoState();
}

class _WaveProgressDemoState extends State<WaveProgressDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('波浪进度条')),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: SyWaveProgress(
              percent: 0.5,
              primaryColor: Colors.blue,
              secondaryColor: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
