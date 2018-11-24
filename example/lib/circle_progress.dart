import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class CircleProgressDemo extends StatefulWidget {
  @override
  _CircleProgressDemoState createState() => _CircleProgressDemoState();
}

class _CircleProgressDemoState extends State<CircleProgressDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('圆形进度条')),
      body: ListView(
        padding: EdgeInsets.all(68.0),
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: SyCircleProgress(
                progress: 0.8,
                primaryColor: Colors.blue,
                secondaryColor: Colors.black12,
              ),
              //color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: SyCircleProgress(
                progress: 0.6,
                primaryColor: Colors.red,
                secondaryColor: Colors.black12,
              ),
              //color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
