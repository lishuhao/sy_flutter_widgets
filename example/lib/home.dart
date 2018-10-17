import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SyCell(
            title: 'Stepper步进器',
            onTap: () {
              Navigator.pushNamed(context, '/stepper');
            },
          ),
          SyCell(
            title: 'Rate 评分',
            onTap: () {
              Navigator.pushNamed(context, '/rate');
            },
          ),
          SyCell(
            title: 'ListView with Load more',
            onTap: () {
              Navigator.pushNamed(context, '/listview');
            },
          ),
          SyCell(
            title: 'GridView with Load more',
            onTap: () {
              Navigator.pushNamed(context, '/gridview');
            },
          ),
        ],
      ),
    );
  }
}
