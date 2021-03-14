import 'package:flutter/material.dart';

typedef StepperChangeCallback(int val);

// - 3 +
class SyStepper extends StatefulWidget {
  final int value;
  final int min;
  final int max;
  final int step; //步幅
  final double size;
  final StepperChangeCallback? onChange;

  const SyStepper(
      {Key? key,
      this.value = 1,
      this.onChange,
      this.min = 1,
      this.max = 9999999,
      this.step = 1,
      this.size = 24.0})
      : super(key: key);

  @override
  _SyStepperState createState() => _SyStepperState();
}

class _SyStepperState extends State<SyStepper> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final iconPadding = const EdgeInsets.all(4.0);
    bool minusBtnDisabled = value <= widget.min ||
        value - widget.step < widget.min ||
        widget.onChange == null;
    bool addBtnDisabled = value >= widget.max ||
        value + widget.step > widget.max ||
        widget.onChange == null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: iconPadding,
            child: Icon(
              Icons.remove,
              size: widget.size,
              color: minusBtnDisabled
                  ? theme.disabledColor
                  : theme.textTheme.button!.color,
            ),
          ),
          onTap: minusBtnDisabled
              ? null
              : () {
                  int newVal = value - widget.step;
                  setState(() {
                    value = newVal;
                  });
                  widget.onChange!(newVal);
                },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: ConstrainedBox(
            child: Center(child: Text(value.toString())),
            constraints: BoxConstraints(minWidth: widget.size),
          ),
        ),
        InkWell(
          child: Padding(
            padding: iconPadding,
            child: Icon(
              Icons.add,
              size: widget.size,
              color: addBtnDisabled
                  ? theme.disabledColor
                  : theme.textTheme.button!.color,
            ),
          ),
          onTap: addBtnDisabled
              ? null
              : () {
                  int newVal = value + widget.step;
                  setState(() {
                    value = newVal;
                  });
                  widget.onChange!(newVal);
                },
        ),
      ],
    );
  }
}
