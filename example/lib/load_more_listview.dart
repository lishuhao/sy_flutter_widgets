import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import 'model/repo.dart';
import 'service/api.dart';

class LoadMoreListView extends StatefulWidget {
  @override
  _LoadMoreListViewState createState() => _LoadMoreListViewState();
}

class _LoadMoreListViewState extends State<LoadMoreListView> {
  List<GithubRepo> _dataList = [];
  bool _loading = true;

  Future<bool> _getDataList(int page) async {
    List<GithubRepo> records = await getRepos(page);
    setState(() {
      _dataList.addAll(records);
      _loading = false;
    });
    return records.length > 0;
  }

  @override
  void initState() {
    super.initState();
    _getDataList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Github search go')), body: _buildBody());
  }

  Widget _buildBody() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SyListViewWithLoadMore(
          itemCount: _dataList.length,
          onLoadMore: _getDataList,
          itemBuilder: (context, i) {
            return _buildItem(i);
          }),
    );
  }

  Widget _buildItem(int i) {
    GithubRepo repo = _dataList[i];
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(repo.avatar ?? ''),
        ),
        title: Text(repo.name ?? ''),
        subtitle: Text(repo.description ?? ''),
      ),
    );
  }
}
