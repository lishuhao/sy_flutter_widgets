import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/src/colors.dart';

typedef int CallBack(int);

//星级评分
class SyRate extends StatefulWidget {
  final int total;
  final int value;
  final bool readOnly;
  final Color color; //选中的颜色
  final Color unselectedColor; //未选中的颜色
  final double iconSize;
  final CallBack onTap;

  const SyRate(
      {Key key,
      this.onTap,
      this.total = 5,
      this.value = 5,
      this.readOnly = false,
      this.color = Colors.red,
      this.unselectedColor = SyColor.subtitle,
      this.iconSize = 24.0})
      : assert(total > 1 && value >= 1,
            'total 或 value 不能小于1'), // 确保total>1 && value>=1
        assert((readOnly == true) || (readOnly == false && onTap != null),
            '如果readOnly为false，onTap 不能为null'),
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
    List<Widget> widgets = [];
    for (int i = 1; i <= widget.total; i++) {
      Widget item = InkWell(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              _starNum >= i ? Icons.star : Icons.star_border,
              color: _starNum >= i ? widget.color : widget.unselectedColor,
              size: widget.iconSize,
            ),
          ),
          onTap: widget.readOnly
              ? null
              : () {
                  setState(() {
                    _starNum = i;
                  });
                  widget.onTap(_starNum);
                });

      widgets.add(item);
    }
    return widgets;
  }
}
