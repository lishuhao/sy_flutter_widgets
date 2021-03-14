import 'dart:async';

import 'package:flutter/material.dart';

typedef void ImagesChangeCallback(List<String> newImages);
typedef Future<String> UploadImageCallback();

/// 点击删除按钮时的回调
typedef RemoveImageCallback(String? removedUrl);

//照片墙
class SyImageWall extends StatefulWidget {
  final Widget? uploadBtn;
  final int rowCount; //item per row
  final int? maxCount; //限制上传数量
  final List<String>? images; //initial images
  final bool reorderable; //是否允许排序
  final ImagesChangeCallback onChange;
  final UploadImageCallback onUpload;
  final RemoveImageCallback? onRemove;

  const SyImageWall({
    Key? key,
    this.rowCount = 4,
    this.maxCount,
    this.images,
    required this.onChange,
    required this.onUpload,
    this.uploadBtn,
    this.reorderable = true,
    this.onRemove,
  }) : super(key: key);

  @override
  _SyImageWallState createState() => _SyImageWallState();
}

class _SyImageWallState extends State<SyImageWall> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final double space = 8.0;
    return InkWell(
      child: GridView.count(
        padding: EdgeInsets.all(space),
        primary: false,
        crossAxisCount: widget.rowCount,
        crossAxisSpacing: space,
        mainAxisSpacing: space,
        children: buildImages(),
      ),
      onLongPress: widget.reorderable
          ? () async {
              //排序
              List<String>? orderedImages = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ReorderImage(
                      images: images,
                    );
                  },
                  fullscreenDialog: true,
                ),
              );
              print(orderedImages);
              if (orderedImages != null) {
                setState(() {
                  images = orderedImages;
                });
              }
            }
          : null,
    );
  }

  List<Widget> buildImages() {
    List<Widget> widgets = [];
    for (int i = 0; i < images.length; i++) {
      widgets.add(_buildImageItem(i));
    }
    if (widget.maxCount == null || images.length < widget.maxCount!) {
      widgets.add(_buildAddImageButton());
    }
    return widgets;
  }

  Widget _buildImageItem(int index) {
    if (images[index].isEmpty) {
      return CircularProgressIndicator();
    }
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Image.network(
          images[index],
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: InkWell(
            child: Icon(Icons.cancel, color: Theme.of(context).disabledColor),
            onTap: () {
              String? removedUrl;
              setState(() {
                removedUrl = images.removeAt(index);
              });
              widget.onChange(images);
              if (widget.onRemove != null) {
                widget.onRemove!(removedUrl);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildAddImageButton() {
    Widget btn = Container(
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Theme.of(context).disabledColor,
        ),
      ),
      child: Icon(Icons.add, color: Theme.of(context).disabledColor),
    );

    return InkWell(
      child: widget.uploadBtn ?? btn,
      onTap: () async {
        String? url = await widget.onUpload();
        if (url.isEmpty) {
          return;
        }
        setState(() {
          images.add(url);
        });
        widget.onChange(images);
      },
    );
  }
}

//-----------

class ReorderImage extends StatefulWidget {
  final List<String>? images;

  const ReorderImage({Key? key, this.images}) : super(key: key);

  @override
  _ReorderImageState createState() => _ReorderImageState();
}

class _ReorderImageState extends State<ReorderImage> {
  List<String>? images;

  @override
  void initState() {
    super.initState();
    images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('长按可排序'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, images);
            },
          )
        ],
      ),
      body: ReorderableListView(
        padding: EdgeInsets.all(8.0),
        onReorder: _onReorder,
        children: images!.map((url) {
          return Row(
            key: Key(url),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Icon(Icons.drag_handle)
            ],
          );
        }).toList(),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = images!.removeAt(oldIndex);
      images!.insert(newIndex, item);
    });
  }
}
