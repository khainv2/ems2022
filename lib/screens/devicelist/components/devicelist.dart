import 'package:admin/models/device.dart';
import 'package:admin/models/msb.dart';
import 'package:admin/screens/devicelist/components/devicedetail.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class DeviceList extends StatefulWidget {
  final Msb msb;
  const DeviceList({ Key? key, required this.msb }) : super(key: key);

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
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
    final online = device.online != null && device.online!;
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
        DataCell(Text(device.name.contains("ACB") ? device.model : device.name)),
        DataCell(Text(device.address ?? device.modbusAddress ?? "")),
        DataCell(Text(
          online ? "Bật" : "Tắt",
          style: TextStyle(color: online ? Color(0xFF00cc00) : Color(0xFFcc0000)),
        )),
        DataCell( 
          Container(constraints: BoxConstraints(maxWidth: 300), child: Text(device.note ?? ""))
        )
      ],
    );
  }
}

