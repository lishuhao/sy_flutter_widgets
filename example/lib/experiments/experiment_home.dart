import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import 'clip_demo.dart';
import 'overlay_demo.dart';
import 'popup_overlay_demo.dart';
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
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SyCell(
            title: '拖动排序',
            icon: Icon(Icons.drag_handle),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ReorderableGridDemo();
              }));
            },
          ),
          SyCell(
            title: 'clip',
            icon: Icon(Icons.drag_handle),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ClipDemo();
              }));
            },
          ),
          SyCell(
            title: 'overlay demo',
            icon: Icon(Icons.remove_circle_outline),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OverlayDemo();
              }));
            },
          ),
          SyCell(
            title: 'popup overlay demo',
            icon: Icon(Icons.remove_circle_outline),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PopupOverlayDemo();
              }));
            },
          ),
        ],
      ),
    );
  }
}
