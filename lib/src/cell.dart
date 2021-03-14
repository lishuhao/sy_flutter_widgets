import 'package:flutter/material.dart';

class SyCell extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String endText;
  final VoidCallback? onTap;

  SyCell({
    required this.title,
    this.icon,
    this.onTap,
    this.endText: '',
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return new InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: theme.dividerColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: icon,
                  )
                : Container(),
            Expanded(
              child: Text(
                title,
              ),
            ),
            Text(endText),
            onTap == null
                ? Container()
                : Icon(
                    Icons.navigate_next,
                    color: theme.disabledColor,
                  )
          ],
        ),
      ),
    );
  }
}
