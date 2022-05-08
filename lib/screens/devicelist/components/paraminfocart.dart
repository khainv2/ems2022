

import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class ParamInfoCart extends StatelessWidget {
  const ParamInfoCart({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultHalfPadding,
        bottom: defaultHalfPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultHalfPadding),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: accentColor
            )
          )
        ],
      ),
    );
  }
}