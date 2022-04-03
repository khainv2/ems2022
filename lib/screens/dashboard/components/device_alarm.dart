import 'package:flutter/material.dart';

import '../../../constants.dart';

class DeviceAlarm extends StatelessWidget {
  const DeviceAlarm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cảnh báo",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Container(
            height: 150,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  Icon(Icons.do_not_disturb_off_outlined),
                  SizedBox(height: defaultPadding),
                  Text("Chưa có dữ liệu")
                ],
              )
            )
          )
        ],
      ),
    );
  }
}
