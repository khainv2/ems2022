import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class EventListScreen extends StatefulWidget {
  const EventListScreen({ Key? key }) : super(key: key);

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}


class _EventListScreenState extends State<EventListScreen> {
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
                    sampleEventList.length,
                    (index){
                      final event = sampleEventList[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(event.num.toString())),
                          DataCell(Text(event.type.toString().split('.').last)),
                          DataCell(Text(event.message)),
                          DataCell(Text(event.time.toString())),
                          DataCell(Text(event.readed ? 'Đã đọc' : 'Chưa đọc'))
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