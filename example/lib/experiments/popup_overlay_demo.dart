import 'package:flutter/material.dart';

class PopupOverlayDemo extends StatefulWidget {
  @override
  _PopupOverlayDemoState createState() => _PopupOverlayDemoState();
}

class _PopupOverlayDemoState extends State<PopupOverlayDemo> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: RaisedButton(
          key: _key,
          child: Text('BUTTON'),
          onPressed: () {
            final RenderBox buttonBox = context.findRenderObject();
            print(buttonBox.size);
            print(context.widget);
            Offset offset =
                buttonBox.localToGlobal(Offset(0, buttonBox.size.height));
            Navigator.push(context, _OverlayRoute(position: offset));
          },
        ),
      ),
    );
  }
}

class _OverlayRoute extends PopupRoute {
  final Offset position;

  _OverlayRoute({this.position});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Builder(
      builder: (BuildContext context) {
        return CustomSingleChildLayout(
          delegate: _PopupOverlayLayout(position: position),
          child: Material(
            elevation: 8.0,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}

const double _kMenuScreenPadding = 8.0;

class _PopupOverlayLayout extends SingleChildLayoutDelegate {
  final Offset position;

  _PopupOverlayLayout({this.position});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest -
        const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0));
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return true;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return position;
  }
}
