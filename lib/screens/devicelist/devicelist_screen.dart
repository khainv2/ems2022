import 'package:admin/models/msblistsample.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/screens/devicelist/components/devicelist.dart';
import 'package:admin/screens/devicelist/components/msblist.dart';
import 'package:flutter/material.dart';
import '../../common.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({ Key? key }) : super(key: key);

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  int _currentMsbSelection = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: MsbList(
              currentMsbIndex: _currentMsbSelection,
              requestChangeCurrentMsb: (int s){
                setState(() {
                  _currentMsbSelection = s;
                });
              },
            )
          ),
          SizedBox(width: defaultPadding),
          Expanded(
            flex: 3,
            child: DeviceList(msb: listMsbSample[_currentMsbSelection],)
          )
        ],
      )
    );
  }
}