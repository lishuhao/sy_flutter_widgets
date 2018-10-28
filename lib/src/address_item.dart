import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/src/badge.dart';
import 'package:sy_flutter_widgets/src/models/address_model.dart';

const _addressItemPadding = 8.0;

class SyAddressItem extends StatelessWidget {
  final SyAddressModel address;
  final VoidCallback onEdit;

  const SyAddressItem({Key key, this.address, @required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(_addressItemPadding),
      margin: EdgeInsets.only(bottom: _addressItemPadding),
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
                      flex: 2,
                      child: Text(
                        address.name,
                        style: theme.textTheme.subhead
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              address.phone,
                              style: theme.textTheme.subhead,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          address.isDefault
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: _addressItemPadding),
                                  child: SyBadge(
                                    text: Text(
                                      '默认',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.0),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _addressItemPadding,
                ),
                Text(address.completeAddress, style: theme.textTheme.body1)
              ],
            ),
          ),
          InkWell(
              child: Padding(
                padding: const EdgeInsets.all(_addressItemPadding),
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
