import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import 'reorderable_grid_demo.dart';

class ExperimentHome extends StatefulWidget {
  @override
  _ExperimentHomeState createState() => _ExperimentHomeState();
}

class _ExperimentHomeState extends State<ExperimentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('实验组件')),
      body: ListView(
        children: <Widget>[
          SyCell(
            title: '拖动排序',
            icon: Icon(Icons.drag_handle),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ReorderableGridDemo();
              }));
            },
          )
        ],
      ),
    );
  }
}
