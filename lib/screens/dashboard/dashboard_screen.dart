import 'package:admin/screens/dashboard/components/device_alarm.dart';
import 'package:admin/screens/dashboard/components/device_status.dart';
import 'package:admin/screens/dashboard/components/overview_event_list.dart';
import 'package:admin/screens/dashboard/components/overviewdevice.dart';
import 'package:admin/screens/dashboard/components/statistic.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: OverviewDevice()
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            flex: 3, 
            child: Row(
              children: [
                Expanded(
                  child: DeviceStatus(),
                ), 
                SizedBox(width: defaultPadding),
                Expanded(
                  child: OverviewEventList(),
                ),  
                SizedBox(width: defaultPadding),
                Expanded(
                  child: Statistic(),
                ),  
                SizedBox(width: defaultPadding),
                Expanded(
                  child: DeviceAlarm(),
                ), 
              ],
            )
          )
        ],
      )
    );
  }
}
