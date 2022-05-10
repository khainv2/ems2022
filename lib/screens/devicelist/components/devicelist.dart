import 'dart:convert';

import 'package:admin/api/realtime.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msb.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/screens/devicelist/devicedetail.dart';
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

  void getDataFromServer(){
    final userControl = UserControl();
    if (userControl.currentStackIndex == 1){
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
    timerQueryData = Timer.periodic(oneSec, (Timer t) => getDataFromServer());   
  }
  
  @override
  Widget build(BuildContext context) {
    final deviceList = widget.msb.deviceList ?? [];
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
            "Danh sách thiết bị",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            // child: Scrollbar(
            //   isAlwaysShown: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: double.infinity,
                  child: DataTable(
                  columnSpacing: 0,
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                      label: Text("Tên"),
                    ),
                    DataColumn(
                      label: Text("Địa chỉ"),
                    ),
                    DataColumn(
                      label: Text("Trạng thái"),
                    ),
                    DataColumn(
                      label: Text("Mô tả"),
                    ),
                  ],
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
      switch (dev.state){
        case DeviceState.Online:
          state = "Bật";
          colorState = Color(0xff00cc00);
          break;
        case DeviceState.Alarm:
          state = 'Cảnh báo';
          colorState = Color(0xFF888888);
          break;
        case DeviceState.Inactive:
          state = 'Không hoạt động';
          colorState = Color(0xFF888888);
          break;
        case DeviceState.Error:
          state = 'Lỗi';
          colorState = Color(0xFFcc0000);
          break;
        default: break;
      }
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
        DataCell(Text(
          state,
          style: TextStyle(color: colorState),
        )),
        DataCell( 
          Container(constraints: BoxConstraints(maxWidth: 300), child: Text(device.note))
        )
      ],
    );
  }
}

