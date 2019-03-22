import 'package:flutter/material.dart';

class OverlayDemo extends StatefulWidget {
  @override
  _OverlayDemoState createState() => _OverlayDemoState();
}

class _OverlayDemoState extends State<OverlayDemo>
    with TickerProviderStateMixin {
  GlobalKey _appBarKey = GlobalKey();
  OverlayEntry _overlayEntry;
  bool _showOverlay = false;

  AnimationController _controller;
  CurvedAnimation _animation;
  double _opacityLevel = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.addListener(() {
      Overlay.of(context).setState(() {
        _opacityLevel = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _willBack() async {
    await Future.delayed(Duration(microseconds: 1));
    try {
      _overlayEntry.remove();
      setState(() {
        _showOverlay = false;
      });
      return false;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willBack,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('overlay demo'),
              floating: true,
              snap: true,
              expandedHeight: 100,
              flexibleSpace: Align(
                key: _appBarKey,
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      OutlineButton.icon(
                        label: Text('BUTTON'),
                        icon: Icon(Icons.expand_more),
                        onPressed: _onPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 500,
              delegate: SliverChildListDelegate(
                <Widget>[
                  Placeholder(),
                  Placeholder(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressed() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
    }
    if (_showOverlay) {
      _overlayEntry.remove();
      _controller.reverse();
    } else {
      Overlay.of(context).insert(_overlayEntry);
      _controller.forward();
    }
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _appBarKey.currentContext.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(builder: (context) {
      return Positioned(
        top: offset.dy + size.height,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Opacity(
          opacity: _opacityLevel,
          child: Stack(
            children: [
              new Container(
                color: Colors.black54.withOpacity(0.5),
                child: GestureDetector(
                  onTap: _onPressed,
                ),
              ),
              Container(
                height: 200,
                color: Colors.grey,
                child: Material(
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(child: Text('重置')),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.red,
                              padding: EdgeInsets.all(14.0),
                              child: Center(
                                  child: Text(
                                '确定',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
