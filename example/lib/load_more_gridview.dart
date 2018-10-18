import 'dart:async';

import 'package:example/model/repo.dart';
import 'package:example/service/api.dart';
import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class LoadMoreGridView extends StatefulWidget {
  @override
  _LoadMoreGridViewState createState() => _LoadMoreGridViewState();
}

class _LoadMoreGridViewState extends State<LoadMoreGridView> {
  List<GithubRepo> _dataList = [];
  bool _loading = true;

  Future<bool> _getDataList(int page) async {
    List<GithubRepo> records = await getRepos(page);
    print(records);
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
      child: SyGridViewWithLoadMore(
          itemCount: _dataList.length,
          onLoadMore: _getDataList,
          delegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 0.8,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0),
          itemBuilder: (context, i) {
            return _buildItem(i);
          }),
    );
  }

  Widget _buildItem(int i) {
    GithubRepo repo = _dataList[i];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(repo.avatar ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              repo.name ?? '',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: Text(
              repo.description ?? '',
            ),
          )
        ],
      ),
    );
  }
}
