import 'package:example/address_list.dart';
import 'package:example/carousel_demo.dart';
import 'package:example/circle_progress.dart';
import 'package:example/colorful_divider_demo.dart';
import 'package:example/home.dart';
import 'package:example/image_upload.dart';
import 'package:example/load_more_gridview.dart';
import 'package:example/load_more_listview.dart';
import 'package:example/rate.dart';
import 'package:example/stepper.dart';
import 'package:example/wave_progress_demo.dart';
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
        '/': (context) => MyHomePage(title: 'sy_flutter_widgets demo'),
        '/stepper': (context) => MyStepper(),
        '/rate': (context) => RateDemo(),
        '/listview': (context) => LoadMoreListView(),
        '/gridview': (context) => LoadMoreGridView(),
        '/image_uploader': (context) => ImageUpload(),
        '/address_edit': (context) => AddressListPage(),
        '/carousel_demo': (context) => CarouselDemo(),
        '/circle_progress_demo': (context) => CircleProgressDemo(),
        '/wave_progress_demo': (context) => WaveProgressDemo(),
        '/colorful_divider_demo': (context) => ColorfulDividerDemo(),
      },
    );
  }
}
