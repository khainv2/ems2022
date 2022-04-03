import 'package:admin/screens/dashboard/components/chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

enum DeviceState {
  On,
  Off,
  Warning
}

class DeviceStatus extends StatelessWidget {
  const DeviceStatus({
    Key? key,
  }) : super(key: key);

  Widget deviceItemStatus(DeviceState state, int num, int percent){
    String stateStr;
    Color stateColor;
    switch (state){
      case DeviceState.On: stateStr = "Bật"; stateColor = primaryColor; break;
      case DeviceState.Off: stateStr = "Tắt"; stateColor = Color(0xFFEE2727); break;
      case DeviceState.Warning: stateStr = "Cảnh báo"; stateColor = Color(0xFFFFCF26); break;
    }
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 25, height: 15,
              decoration: BoxDecoration(color: stateColor),
            ),
            Expanded(child: Container()),
            Text(stateStr),
          ],
        ),
        Row(
          children: [
            Text(num.toString()),
            Expanded(child: Container()),
            Text(percent.toString() + "%"),
          ],
        ),
      ],
    );
  }

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
            "Trạng thái thiết bị",
            style: Theme.of(context).textTheme.subtitle1,
          ),
              SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(child: Chart(),),
              SizedBox(width: defaultPadding),
              Expanded(
                child: Column(
                  children: [
                    deviceItemStatus(DeviceState.On, 10, 50),
                    SizedBox(height: defaultHalfPadding),
                    deviceItemStatus(DeviceState.Off, 2, 10),
                    SizedBox(height: defaultHalfPadding),
                    deviceItemStatus(DeviceState.Warning, 8, 40),
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
