import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/src/badge.dart';
import 'package:sy_flutter_widgets/src/models/address_model.dart';

class SyAddressItem extends StatelessWidget {
  final SyAddressModel address;
  final VoidCallback onEdit;

  const SyAddressItem({Key key, this.address, @required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        address.name,
                        style: theme.textTheme.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        address.phone,
                        style: theme.textTheme.subhead,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    address.isDefault
                        ? SyBadge(
                            text: Text(
                              '默认',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(address.completeAddress, style: theme.textTheme.body1)
              ],
            ),
          ),
          InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  size: 18.0,
                  color: Colors.black54,
                ),
              ),
              onTap: onEdit)
        ],
      ),
    );
  }
}
