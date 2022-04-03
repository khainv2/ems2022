import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class LogListScreen extends StatefulWidget {
  const LogListScreen({ Key? key }) : super(key: key);

  @override
  State<LogListScreen> createState() => _LogListScreenState();
}


class _LogListScreenState extends State<LogListScreen> {
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
                      label: Text("STT"),
                    ),
                    DataColumn(
                      label: Text("Loại"),
                    ),
                    DataColumn(
                      label: Text("Thông báo"),
                    ),
                    DataColumn(
                      label: Text("Thời gian"),
                    ),
                    DataColumn(
                      label: Text("Trạng thái"),
                    ),
                  ],
                  rows: List.generate(
                    sampleLogList.length,
                    (index){
                      final log = sampleLogList[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(log.num.toString())),
                          DataCell(Text(log.type.toString().split('.').last)),
                          DataCell(Text(log.message)),
                          DataCell(Text(log.time.toString())),
                          DataCell(Text(log.readed ? 'Đã đọc' : 'Chưa đọc'))
                        ],
                      );
                    },
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
}