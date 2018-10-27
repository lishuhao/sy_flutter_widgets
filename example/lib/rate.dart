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
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Text('基本'),
            SyRate(
              onTap: (v) {
                print(v);
              },
            ),
            Text('只读'),
            SyRate(
              value: 4,
            ),
            Text('自定义图标'),
            SyRate(
              icon: Icons.favorite,
            ),
            Text('自定义颜色及大小'),
            Theme(
              data: Theme.of(context).copyWith(
                  accentColor: Colors.red,
                  disabledColor: Colors.deepOrangeAccent),
              child: SyRate(
                iconSize: 16.0,
              ),
            )
          ],
        ));
  }
}
