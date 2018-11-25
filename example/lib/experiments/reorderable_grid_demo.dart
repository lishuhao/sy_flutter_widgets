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
                key: ValueKey(item),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                ),
                child: Center(
                  child: Text(item),
                ),
              );
            }).toList(),
            onReorder: (oldIndex, newIndex) {
              final oldItem = words[oldIndex];
              final newItem = words[newIndex];
              setState(() {
                words[oldIndex] = newItem;
                words[newIndex] = oldItem;
              });
            },
          ),
        ));
  }
}
