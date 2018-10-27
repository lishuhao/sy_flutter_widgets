import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class MyStepper extends StatefulWidget {
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stepper 步进器')),
      body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Text('基础')),
                  SyStepper(
                    onChange: (v) {},
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Text('高级')),
                  SyStepper(
                    value: 2,
                    step: 2,
                    onChange: (v) {},
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Text('禁用')),
                  SyStepper(
                    value: 5,
                  )
                ],
              )
            ],
          )),
    );
  }
}
