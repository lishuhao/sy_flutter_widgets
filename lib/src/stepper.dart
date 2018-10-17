import 'package:flutter/material.dart';

typedef StepperChangeCallback(int val);

// - 3 +
class SyStepper extends StatefulWidget {
  final int initialVal;
  final int min;
  final int max;
  final int step; //步幅
  final StepperChangeCallback onChange;

  const SyStepper(
      {Key key,
      this.initialVal = 1,
      @required this.onChange,
      this.min = 1,
      this.max = 99999,
      this.step = 1})
      : super(key: key);

  @override
  _SyStepperState createState() => _SyStepperState();
}

class _SyStepperState extends State<SyStepper> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialVal;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: value <= widget.min
              ? null
              : () {
                  int newVal = value - widget.step;
                  setState(() {
                    value = newVal;
                  });
                  widget.onChange(newVal);
                },
        ),
        Text(value.toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: value >= widget.max
              ? null
              : () {
                  int newVal = value + widget.step;
                  setState(() {
                    value = newVal;
                  });
                  widget.onChange(newVal);
                },
        ),
      ],
    );
  }
}
