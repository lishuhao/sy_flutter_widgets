import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/src/utils.dart';

//加载更多回调函数
//返回值 是否还有更多数据
//page 当前页

//自带下拉刷新、上拉加载更多的 list view
class SyListViewWithLoadMore extends StatefulWidget {
  final int itemCount;
  final double itemExtent;
  final IndexedWidgetBuilder itemBuilder;

  final PullCallback onLoadMore;
  final RefreshCallback onRefresh;
  final ScrollPhysics physics;

  const SyListViewWithLoadMore(
      {Key key,
      @required this.itemCount,
      @required this.onLoadMore,
      @required this.itemBuilder,
      this.onRefresh,
      this.itemExtent,
      this.physics})
      : super(key: key);

  @override
  _SyListViewWithLoadMoreState createState() => _SyListViewWithLoadMoreState();
}

class _SyListViewWithLoadMoreState extends State<SyListViewWithLoadMore> {
  ScrollController _scrollController;

  bool _loadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;

  void _scrollListener() async {
    double remainSpace = _scrollController.position.extentAfter;
    if (remainSpace < 10.0) {
      if (!_loadingMore) {
        if (_hasMore) {
          setState(() {
            _loadingMore = true;
            _currentPage += 1;
          });
          bool hasMore = await widget.onLoadMore(_currentPage);
          setState(() {
            _loadingMore = false;
            _hasMore = hasMore;
          });
        } else {
          setState(() {
            _hasMore = false;
          });
          print('没有更多数据');
        }
      }
    }
  }

  Future<Null> _onRefresh() async {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
    });
    widget.onRefresh();
    return null;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              physics:widget.physics,
              itemExtent: widget.itemExtent,
              controller: _scrollController,
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder),
        ),
        _loadingMore
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container()
      ],
    );
    if (widget.onRefresh == null) {
      return body;
    } else {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: body,
      );
    }
  }
}
