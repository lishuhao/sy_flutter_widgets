import 'dart:ui';

import 'package:flutter/material.dart';

class ClipDemo extends StatefulWidget {
  @override
  _ClipDemoState createState() => _ClipDemoState();
}

class _ClipDemoState extends State<ClipDemo> {
  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        image: DecorationImage(
          image: NetworkImage(
            'https://s1.ljcdn.com/feroot/pc/asset/ershoufang/component/img/yezhu-xiazai.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      foregroundDecoration: BoxDecoration(
        //color: Colors.black45,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );

    final Widget filterWidget = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        FlutterLogo(
          size: 200.0,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.black12,
              child: Center(
                child: Text(
                  'FILTER',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(title: Text('Clip demo')),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            ClipPath(
              child: Container(
                height: 100.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              clipper: _Clipper(),
            ),
            ClipPath(
              child: Container(
                height: 200.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              clipper: _Clipper2(),
            ),
            ClipPath(
              child: Container(
                height: 200.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              clipper: _Clipper3(),
            ),
            container,
            filterWidget,
          ],
        ));
  }
}

class _Clipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();
    path.lineTo(0, h - 40);
    path.quadraticBezierTo(w / 2, h + 20, w, h - 40);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class _Clipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();
    path.lineTo(0, h);
    path.lineTo(w, h - 50);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class _Clipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
