import 'package:example/home.dart';
import 'package:example/image_upload.dart';
import 'package:example/load_more_gridview.dart';
import 'package:example/load_more_listview.dart';
import 'package:example/rate.dart';
import 'package:example/stepper.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/stepper': (context) => MyStepper(),
        '/rate': (context) => RateDemo(),
        '/listview': (context) => LoadMoreListView(),
        '/gridview': (context) => LoadMoreGridView(),
        '/image_uploader': (context) => ImageUpload()
      },
    );
  }
}
