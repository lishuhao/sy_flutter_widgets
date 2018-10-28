import 'package:flutter/material.dart';

class SyBadge extends StatelessWidget {
  final Widget text;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const SyBadge({Key key, this.text, this.padding, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
      decoration: ShapeDecoration(
          color: backgroundColor ?? Colors.red, shape: StadiumBorder()),
      child: text,
    );
  }
}
