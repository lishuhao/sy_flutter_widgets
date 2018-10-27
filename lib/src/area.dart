//省市区选择器
import 'dart:convert';

import 'package:flutter/material.dart';

import '_area_data.dart';

class SyArea extends StatefulWidget {
  final Widget title;

  const SyArea({Key key, this.title}) : super(key: key);

  @override
  _SyAreaState createState() => _SyAreaState();
}

class _SyAreaState extends State<SyArea> {
  final _areaData = json.decode(areaData);
  Map<String, dynamic> _provinces;

  Map<String, dynamic> _cities;
  Map<String, dynamic> _counties;

  //选中的
  String _selectedProvinceCode = '110000';
  String _selectedCityCode = '110100';
  String _selectedCountyCode = '110101';

  Map<String, dynamic> _getCities(String areaCode) {
    Map<String, dynamic> cities = new Map();
    (_areaData['city_list'] as Map<String, dynamic>)
        .forEach((String key, dynamic val) {
      if (areaCode.substring(0, 2) == key.substring(0, 2)) {
        cities[key] = val;
      }
    });
    return cities;
  }

  Map<String, dynamic> _getCounties(String areaCode) {
    Map<String, dynamic> counties = new Map();
    (_areaData['county_list'] as Map<String, dynamic>)
        .forEach((String key, dynamic val) {
      if (areaCode.substring(0, 4) == key.substring(0, 4)) {
        counties[key] = val;
      }
    });
    return counties;
  }

  @override
  void initState() {
    super.initState();
    _provinces = _areaData['province_list'];
    _cities = _getCities(_selectedProvinceCode);
    _counties = _getCounties(_selectedCityCode);
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
            province: _areaData['province_list'][_selectedProvinceCode],
            city: _areaData['city_list'][_selectedCityCode],
            county: _areaData['county_list'][_selectedCountyCode],
            areaCode: _selectedCountyCode));
  }

  Widget _buildProvince() {
    List<Widget> widgets = [];
    _provinces.forEach((String areaCode, dynamic val) {
      Widget btn = _myFlatButton(
        text: val,
        onPressed: _selectedProvinceCode == areaCode
            ? null
            : () {
                setState(() {
                  _selectedProvinceCode = areaCode;
                  _cities = _getCities(areaCode);
                  _selectedCityCode = _cities.keys.first;
                  _counties = _getCounties(_selectedCityCode);
                  _selectedCountyCode = _counties.keys.first;
                });
              },
      );
      widgets.add(btn);
    });
    return new Expanded(
      child: Container(
        decoration: _listBorder(),
        child: ListView(
          itemExtent: 40.0,
          children: widgets,
        ),
      ),
    );
  }

  Widget _buildCity() {
    List<Widget> widgets = [];
    _cities.forEach((String areaCode, dynamic val) {
      Widget btn = _myFlatButton(
        text: val,
        onPressed: _selectedCityCode == areaCode
            ? null
            : () {
                setState(() {
                  _selectedCityCode = areaCode;
                  _counties = _getCounties(areaCode);
                  _selectedCountyCode = _counties.keys.first;
                });
              },
      );
      widgets.add(btn);
    });
    return new Expanded(
      child: Container(
        decoration: _listBorder(),
        child: ListView(
          itemExtent: 40.0,
          children: widgets,
        ),
      ),
    );
  }

  Widget _buildCounties() {
    List<Widget> widgets = [];
    _counties.forEach((String areaCode, dynamic val) {
      Widget btn = _myFlatButton(
        text: val,
        onPressed: _selectedCountyCode == areaCode
            ? null
            : () {
                setState(() {
                  _selectedCountyCode = areaCode;
                });
              },
      );
      widgets.add(btn);
    });
    return Expanded(
      child: ListView(
        itemExtent: 40.0,
        children: widgets,
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

//---------------------------

class SyAreaModel {
  String province;
  String city;
  String county;
  String areaCode;

  SyAreaModel({this.province, this.city, this.county, this.areaCode});

  Map<String, dynamic> toJson() => {
        "province": province,
        "city": city,
        "county": county,
        "area_code": areaCode
      };
}
