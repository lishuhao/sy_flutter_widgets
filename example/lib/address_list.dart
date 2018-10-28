import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<SyAddressModel> _addressList = [
    SyAddressModel(
        name: '张三',
        phone: '18323244424',
        province: '北京市',
        city: '北京城区',
        county: '丰台区',
        detailAddress: '洋桥北里128号楼 ',
        isDefault: true),
    SyAddressModel(
        name: '李四',
        phone: '18323244424',
        province: '北京市',
        city: '北京城区',
        county: '丰台区',
        detailAddress: '洋桥北里128号楼',
        isDefault: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('地址编辑'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SyAddressEdit(
                    onSave: (address) {
                      print(address.toJson());
                    },
                  );
                }));
              },
            )
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: _addressList.map((item) {
            return SyAddressItem(
              address: item,
              onEdit: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SyAddressEdit(
                    address: item,
                    onSave: (address) {
                      print(address.toJson());
                    },
                  );
                }));
              },
            );
          }).toList(),
        ));
  }
}
