import 'package:flutter/material.dart';

class ExperimentHome extends StatefulWidget {
  @override
  _ExperimentHomeState createState() => _ExperimentHomeState();
}

class _ExperimentHomeState extends State<ExperimentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('实验组件')), body: CustomScrollView());
  }
}
