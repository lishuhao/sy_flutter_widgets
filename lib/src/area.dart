//省市区选择器
import 'dart:convert';

import 'package:flutter/material.dart';

import '_area_data.dart';
import 'models/area_model.dart';

class SyArea extends StatefulWidget {
  final Widget title;
  final String initProvince;
  final String initCity;
  final String initCounty;

  const SyArea(
      {Key key,
      this.title,
      this.initProvince = '',
      this.initCity = '',
      this.initCounty = ''})
      : super(key: key);

  @override
  _SyAreaState createState() => _SyAreaState();
}

class _SyAreaState extends State<SyArea> {
  final _areaData = json.decode(areaData);
  List<String> _provinces;
  List<String> _cities;
  List<String> _counties;

  //选中的
  String _selectedProvince;
  String _selectedCity;
  String _selectedCounty;

  List<String> _getCities(String province) {
    if (_areaData[province] == null) {
      return new List();
    }
    return (_areaData[province] as Map).keys.toList();
  }

  List<String> _getCounties(String province, String city) {
    if (_areaData[province] == null || _areaData[province][city] == null) {
      return new List();
    }
    return (_areaData[province][city] as List)
        .map((item) => item.toString())
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _provinces = _areaData.keys.toList();

    List<String> cities = _getCities(widget.initProvince);
    List<String> counties = _getCounties(widget.initProvince, widget.initCity);
    if (!cities.contains(widget.initCity) ||
        (counties.length > 0 && !counties.contains(widget.initCounty))) {
      //没找到初始值
      _selectedProvince = _provinces.first;
      _cities = _getCities(_selectedProvince);
      _selectedCity = _cities.first;
      _counties = _getCounties(_selectedProvince, _selectedCity);
      _selectedCounty = _counties[0];
    } else {
      _selectedProvince = widget.initProvince;
      _selectedCity = widget.initCity;
      _selectedCounty = widget.initCounty;

      _cities = _getCities(_selectedProvince);
      _counties = _getCounties(_selectedProvince, _selectedCity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.title ?? Text('请选择地址'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _onConfirm,
            )
          ],
        ),
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            children: <Widget>[
              _buildProvince(),
              _buildCity(),
              _buildCounties()
            ],
          ),
        ));
  }

  _onConfirm() {
    Navigator.pop(
        context,
        new SyAreaModel(
            province: _selectedProvince,
            city: _selectedCity,
            county: _selectedCounty ?? ''));
  }

  Widget _buildProvince() {
    return Expanded(
      child: Container(
        decoration: _listBorder(),
        child: ListView(
          itemExtent: 40.0,
          children: _provinces.map((province) {
            return _myFlatButton(
              text: province,
              onPressed: _selectedProvince == province
                  ? null
                  : () {
                      setState(() {
                        _selectedProvince = province;
                        _cities = _getCities(province);
                        _selectedCity = _cities.first;
                        _counties =
                            _getCounties(_selectedProvince, _selectedCity);
                        _selectedCounty = _counties.first;
                      });
                    },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCity() {
    return new Expanded(
      child: Container(
        decoration: _listBorder(),
        child: ListView(
          itemExtent: 40.0,
          children: _cities.map((city) {
            return _myFlatButton(
              text: city,
              onPressed: _selectedCity == city
                  ? null
                  : () {
                      final counties = _getCounties(_selectedProvince, city);
                      setState(() {
                        _selectedCity = city;
                        _counties = counties.length > 0 ? counties : new List();
                        _selectedCounty =
                            counties.length > 0 ? _counties.first : '';
                      });
                    },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCounties() {
    return Expanded(
      child: ListView(
        itemExtent: 40.0,
        children: _counties.map((county) {
          return _myFlatButton(
            text: county,
            onPressed: _selectedCounty == county
                ? null
                : () {
                    setState(() {
                      _selectedCounty = county;
                    });
                  },
          );
        }).toList(),
      ),
    );
  }

  BoxDecoration _listBorder() => BoxDecoration(
      border: Border(right: BorderSide(color: Theme.of(context).dividerColor)));

  Widget _myFlatButton({String text, VoidCallback onPressed}) {
    ThemeData theme = Theme.of(context);
    return FlatButton(
      textColor: theme.hintColor,
      disabledColor: theme.cardColor,
      disabledTextColor: theme.textTheme.title.color,
      onPressed: onPressed,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
