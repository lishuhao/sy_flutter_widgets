import 'package:flutter/material.dart';

class HeroDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'hero_tag',
                child: Container(
                  height: 200.0,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ));
  }
}
