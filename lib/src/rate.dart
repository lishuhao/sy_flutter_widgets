import 'package:flutter/material.dart';

typedef int CallBack(int);

//星级评分
class SyRate extends StatefulWidget {
  final int total; //总数
  final int value; //当前数
  final IconData icon;
  final double iconSize;
  final CallBack onTap;

  const SyRate(
      {Key key,
      this.onTap,
      this.total = 5,
      this.value = 3,
      this.iconSize = 24.0,
      this.icon})
      : assert(total > 1 && value >= 1,
            'total 或 value 不能小于1'), // 确保total>1 && value>=1
        super(key: key);

  @override
  _SyRateState createState() => _SyRateState();
}

class _SyRateState extends State<SyRate> {
  int _starNum;

  @override
  void initState() {
    super.initState();
    _starNum = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    ThemeData theme = Theme.of(context);

    List<Widget> widgets = [];
    for (int i = 1; i <= widget.total; i++) {
      Widget item = Container(
        margin: EdgeInsets.only(right: widget.iconSize / 4),
        child: InkWell(
            child: Icon(
              widget.icon ?? Icons.star,
              color: _starNum >= i
                  ? theme.accentColor
                  : theme.disabledColor.withOpacity(0.2),
              size: widget.iconSize,
            ),
            onTap: widget.onTap == null
                ? null
                : () {
                    setState(() {
                      _starNum = i;
                    });
                    widget.onTap(_starNum);
                  }),
      );

      widgets.add(item);
    }
    return widgets;
  }
}
