import 'package:flutter/material.dart';

import 'address_list.dart';
import 'carousel_demo.dart';
import 'circle_progress.dart';
import 'colorful_divider_demo.dart';
import 'home.dart';
import 'image_upload.dart';
import 'load_more_gridview.dart';
import 'load_more_listview.dart';
import 'rate.dart';
import 'stepper.dart';
import 'wave_progress_demo.dart';

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
