import 'dart:async';

import 'package:admin/api/systemlog.dart';
import 'package:admin/controllers/user_control.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class LogListScreen extends StatefulWidget {
  const LogListScreen({ Key? key }) : super(key: key);

  @override
  State<LogListScreen> createState() => _LogListScreenState();
}

class _LogListScreenState extends State<LogListScreen> {
  Timer? timerQueryData;
  List<Event> events = [];
  final defaultPageSize = 15;
  int currentPage = 0;
  int countPage = 0;
  
  @override
  void initState(){
    super.initState();
    timerQueryData = Timer.periodic(Duration(seconds: 3), (Timer t){
      final userControl = UserControl();
      if (userControl.currentStackIndex == 3){
        getSystemLog(1, defaultPageSize).then((value){
          
        });
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
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
            "Danh sách sự kiện",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
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
            )
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("1")),
              ElevatedButton(onPressed: (){}, child: Text("2")),
              ElevatedButton(onPressed: (){}, child: Text("3")),
              Text("..."),
              ElevatedButton(onPressed: (){}, child: Text("3")),
            ],
          )
        ],
      ),
    );
  }
}