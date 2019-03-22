import 'package:flutter/material.dart';

import 'reorderable_grid.dart';

class ReorderableGridDemo extends StatefulWidget {
  @override
  _ReorderableGridDemoState createState() => _ReorderableGridDemoState();
}

class _ReorderableGridDemoState extends State<ReorderableGridDemo> {
  List<String> words =
      List.generate(9, (index) => index.toString() + index.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReorderableGridDemo')),
      body: Container(
        child: SyReorderableGrid(
          children: words.map((item) {
            return Container(
              key: ObjectKey('ddd'),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Center(
                child: Text(item),
              ),
            );
          }).toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final String item = words.removeAt(oldIndex);
              words.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}
