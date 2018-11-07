import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

List<String> _images = [
  'https://gw.alipayobjects.com/zos/rmsportal/iZBVOIhGJiAnhplqjvZW.png',
  'https://gw.alipayobjects.com/zos/rmsportal/uMfMFlvUuceEyPpotzlq.png',
  'https://gw.alipayobjects.com/zos/rmsportal/iZBVOIhGJiAnhplqjvZW.png',
  'https://gw.alipayobjects.com/zos/rmsportal/uMfMFlvUuceEyPpotzlq.png',
];

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Carousel 走马灯')),
        body: ListView(
          children: <Widget>[
            new Container(
              height: 220.0,
              child: SyCarousel(
                autoPlay: true,
                dotSize: 10.0,
                showIndicators: true,
                children: _images.map((item) {
                  return Image.network(
                    item,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
            ),
            new SizedBox(
              height: 30.0,
            ),
            new Container(
              height: 180.0,
              child: SyCarousel(
                autoPlay: true,
                dotSize: 10.0,
                showIndicators: false,
                viewportFraction: 0.8,
                children: _images.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }
}
