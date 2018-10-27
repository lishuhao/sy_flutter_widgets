import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('图片墙')),
        body: Container(
          child: SyImageWall(
              reorderable: true,
              images: [
                'http://qn.isanye.cn/avatar.png',
                'https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png',
                'https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png'
              ],
              onChange: (images) {
                print(images);
              },
              onUpload: () async {
                await Future.delayed(Duration(seconds: 1));
                return 'http://qn.isanye.cn/avatar.png?ts=' +
                    DateTime.now().toIso8601String();
              }),
        ));
  }
}
