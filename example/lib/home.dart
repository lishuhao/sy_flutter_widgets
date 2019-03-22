import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import 'experiments/experiment_home.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget area = new Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: SyCell(
        icon: Icon(Icons.location_on),
        title: '省市区地址选择器',
        onTap: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Theme(
                      data: Theme.of(context)
                          .copyWith(scaffoldBackgroundColor: Colors.grey[100]),
                      child: SyArea(
                        title: Text('请选择地址'),
                      ),
                    );
                  },
                  fullscreenDialog: true));
          print(result == null ? null : result.toJson());
        },
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExperimentHome(); //实验性质的组件
                }));
              }),
        ],
      ),
      body: new ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SyCell(
            icon: Icon(Icons.add),
            title: 'Stepper步进器',
            onTap: () {
              Navigator.pushNamed(context, '/stepper');
            },
          ),
          SyCell(
            icon: Icon(Icons.star_border),
            title: 'Rate 评分',
            onTap: () {
              Navigator.pushNamed(context, '/rate');
            },
          ),
          SyCell(
            icon: Icon(Icons.filter_list),
            title: 'ListView with Load more',
            onTap: () {
              Navigator.pushNamed(context, '/listview');
            },
          ),
          SyCell(
            icon: Icon(Icons.grid_on),
            title: 'GridView with Load more',
            onTap: () {
              Navigator.pushNamed(context, '/gridview');
            },
          ),
          SyCell(
            icon: Icon(Icons.image),
            title: '图片墙',
            onTap: () {
              Navigator.pushNamed(context, '/image_uploader');
            },
          ),
          SyCell(
            icon: Icon(Icons.repeat),
            title: 'Carousel 走马灯',
            onTap: () {
              Navigator.pushNamed(context, '/carousel_demo');
            },
          ),
          SyCell(
            icon: Icon(Icons.autorenew),
            title: '圆形进度条',
            onTap: () {
              Navigator.pushNamed(context, '/circle_progress_demo');
            },
          ),
          SyCell(
            icon: Icon(Icons.all_inclusive),
            title: '波浪进度条',
            onTap: () {
              Navigator.pushNamed(context, '/wave_progress_demo');
            },
          ),
          SyCell(
            icon: Icon(Icons.linear_scale),
            title: '彩色分隔条',
            onTap: () {
              Navigator.pushNamed(context, '/colorful_divider_demo');
            },
          ),
          SyCell(
            icon: Icon(Icons.location_city),
            title: '地址编辑',
            onTap: () {
              Navigator.pushNamed(context, '/address_edit');
            },
          ),
          area,
        ],
      ),
    );
  }
}
