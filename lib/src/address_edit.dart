import 'package:flutter/material.dart';

import 'area.dart';
import 'models/address_model.dart';
import 'models/area_model.dart';

const EmptyAreaText = '选择省/市/区';
typedef void SaveCallback(SyAddressModel? address);

class SyAddressEdit extends StatefulWidget {
  final SyAddressModel? address;
  final SaveCallback onSave;

  SyAddressEdit({this.address, required this.onSave});

  @override
  _SyAddressEditState createState() => new _SyAddressEditState();
}

class _SyAddressEditState extends State<SyAddressEdit> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _areaController = TextEditingController();

  SyAddressModel? _address;

  @override
  void initState() {
    super.initState();
    _address = widget.address ?? SyAddressModel();
    _areaController.text =
        _address!.province!.isEmpty ? EmptyAreaText : _address!.area;
  }

  @override
  Widget build(BuildContext context) {
    Widget nameField = new TextFormField(
      initialValue: _address!.name,
      decoration: InputDecoration(
          labelText: '收货人',
          hintText: '请使用真实姓名',
          hintStyle: TextStyle(fontSize: 12.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return '请填写收货人姓名';
        }
      },
      onSaved: (String? value) {
        _address!.name = value;
      },
    );

    Widget phoneField = new TextFormField(
      initialValue: _address!.phone,
      decoration: InputDecoration(
          labelText: '电话',
          hintText: '收货人手机号',
          hintStyle: TextStyle(fontSize: 12.0)),
      validator: _validPhone,
      onSaved: (String? value) {
        _address!.phone = value;
      },
    );

    Widget areaField = InkWell(
      child: new TextField(
        controller: _areaController,
        enabled: false,
        decoration: InputDecoration(
            labelText: '地区', hintStyle: TextStyle(fontSize: 12.0)),
      ),
      onTap: () async {
        SyAreaModel? result =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SyArea(
            initProvince: _address!.province,
            initCity: _address!.city,
            initCounty: _address!.county,
          );
        }));
        if (result != null) {
          setState(() {
            _address!.province = result.province;
            _address!.city = result.city;
            _address!.county = result.county;
          });
          _areaController.text = _address!.area;
        }
      },
    );

    Widget detailField = new TextFormField(
      initialValue: _address!.detailAddress,
      decoration: InputDecoration(
          labelText: '详细地址',
          hintText: '（如街道、小区、乡镇、村）',
          hintStyle: TextStyle(fontSize: 12.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return '请填写详细地址';
        }
      },
      onSaved: (String? value) {
        _address!.detailAddress = value;
      },
    );

    Widget defaultAddress = new Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('设为默认收货地址'),
          Switch(
              value: _address!.isDefault,
              onChanged: (val) {
                setState(() {
                  _address!.isDefault = val;
                });
              })
        ],
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.address == null ? '新建收货地址' : '编辑收货地址'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _onSubmit,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              nameField,
              phoneField,
              areaField,
              detailField,
              defaultAddress,
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_areaController.text.isEmpty || _areaController.text == EmptyAreaText) {
      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text('请选择收货地址')));
      return;
    }
    _formKey.currentState!.save();
    widget.onSave(_address);
    Navigator.pop(context);
  }

  String? _validPhone(String? phone) {
    if (phone!.isEmpty) {
      return '请输入手机号码';
    }
    if (phone.length != 11) {
      return '请输入正确的手机号码';
    }
    return null;
  }
}
