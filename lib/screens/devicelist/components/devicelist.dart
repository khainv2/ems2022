import 'dart:convert';

import 'package:admin/api/realtime.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msb.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/screens/devicelist/devicedetail.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DeviceList extends StatefulWidget {
  final Msb msb;
  const DeviceList({ Key? key, required this.msb }) : super(key: key);

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  Timer? timerQueryData;
  DeviceTable deviceTable = DeviceTable({}, {});

  void getRealtimeAndUpdate(){
    final userControl = UserControl();
    if (userControl.currentStackIndex == deviceListIndex){
      getRealtimeAllDevice().then((value){
        setState(() {
          deviceTable = value;
        });
      });
    }
  }

  @override
  void initState(){
    super.initState();
    const oneSec = Duration(seconds: 3);
    timerQueryData = Timer.periodic(oneSec, (Timer t) => getRealtimeAndUpdate());  
    final userControl = UserControl();
    userControl.addStackIndexChangeListener((_){
      getRealtimeAndUpdate();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final deviceList = widget.msb.deviceList ?? [];
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Danh sách thiết bị",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: defaultPadding),
          Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: double.infinity,
                  child: DataTable(
                    border: defaultTableBorder,
                    columnSpacing: defaultPadding,
                    showCheckboxColumn: false,
                    columns: ['Tên', 'Địa chỉ', 'Trạng thái', 'Mô tả']
                      .map((title) => DataColumn(
                        label: Expanded(
                          child: Text(title, style: defaultTableHeaderStyle)
                        )
                      )
                    ).toList(),
                    rows: List.generate(
                      deviceList.length,
                      (index) => getDataRow(deviceList[index], index),
                    ),
                  ),
                )
              // )
            )
            
          ),
        ],
      ),
    );
  }

  DataRow getDataRow(Device device, int index){
    String state = 'Tắt';
    Color colorState = Color(0xFFcc0000);
    Device? dev;
    if (device.type == DeviceType.ACB){
      if (deviceTable.acbDevices.containsKey(device.name)){
        dev = deviceTable.acbDevices[device.name];
      }
    } else {
      if (deviceTable.multimeterDevices.containsKey(device.name)){
        dev = deviceTable.multimeterDevices[device.name];
      }
    }
    if (dev != null){
      state = dev.stateStr();
      colorState = dev.stateColor();
    }
    return DataRow(
      onSelectChanged: (v){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return DeviceDetail(device: device);
          }),
        );
      },
      cells: [
        DataCell(Text(device.name)),
        DataCell(Text(device.address)),
        DataCell(Text(state, style: TextStyle(color: colorState))),
        DataCell( 
          Container(
            constraints: BoxConstraints(maxWidth: 320), 
            child: Text(device.note)
          )
        )
      ],
    );
  }
}

