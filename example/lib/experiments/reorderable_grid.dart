import 'package:flutter/material.dart';

typedef ReorderCallback = void Function(int oldIndex, int newIndex);

class SyReorderableGrid extends StatefulWidget {
  final List<Widget> children;
  final ReorderCallback onReorder;
  final double childAspectRatio;
  final int crossAxisCount;

  SyReorderableGrid(
      {Key key,
      @required this.onReorder,
      @required this.children,
      this.childAspectRatio = 1.0,
      this.crossAxisCount = 3})
      : super(key: key);

  @override
  _SyReorderableGridState createState() => _SyReorderableGridState();
}

class _SyReorderableGridState extends State<SyReorderableGrid> {
  int _dragStartIndex;
  int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: _buildBody(),
    );
  }

  List<Widget> _buildBody() {
    final len = widget.children.length;
    List<Widget> widgets = [];
    for (int i = 0; i < len; i++) {
      widgets.add(_buildItem(i));
    }
    return widgets;
  }

  Widget _buildItem(int index) {
    final feedbackItemWidth =
        MediaQuery.of(context).size.width / widget.crossAxisCount;
    final feedbackItemHeight = feedbackItemWidth * widget.childAspectRatio;
    Widget w = widget.children[index];
    return DragTarget(
      builder: (BuildContext context, List<int> candidateData,
          List<dynamic> rejectedData) {
        return LongPressDraggable(
          child: _dragStartIndex == index ? SizedBox() : w,
          feedback: Container(
            height: feedbackItemHeight,
            width: feedbackItemWidth,
            child: Material(
              elevation: 6.0,
              child: w,
            ),
          ),
          data: index,
          maxSimultaneousDrags: 1,
          dragAnchor: DragAnchor.child,
          onDragStarted: () {
            setState(() {
              _dragStartIndex = index;
              _currentIndex = index;
            });
          },
          onDragCompleted: () {
            setState(() {
              _dragStartIndex = null;
            });
          },
          onDragEnd: (DraggableDetails details) {
            setState(() {
              _dragStartIndex = null;
            });
          },
        );
      },
      onWillAccept: (data) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
        return true;
      },
      onAccept: (data) {
        if (data != index) {
          widget.onReorder(_dragStartIndex, _currentIndex);
        }
        return true;
      },
    );
  }
}
