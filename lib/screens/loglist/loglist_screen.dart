import 'dart:async';

import 'package:admin/api/systemlog.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
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
  List<Log> logs = [];
  final defaultPageSize = 10;
  int currentPage = 1;
  int countPage = 1;
  
  void getDataLogs(){
    getSystemLog(currentPage, defaultPageSize).then((value){
      setState(() {
        logs = value.eventList;
        countPage = value.totalPage;
        currentPage = value.currentPage;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    timerQueryData = Timer.periodic(Duration(seconds: 3), (Timer t){
      final userControl = UserControl();
      if (userControl.currentStackIndex == 3){
        getDataLogs();
      }
    });
    getDataLogs();
  }

  @override
  void dispose(){
    super.dispose();
  }

  List<Widget> createPageButton(){
    List<Widget> output = [];
    for (int i = 1; i <= countPage; i++){
      if (i == currentPage){
        final currentPageText = Container(
          child: Center(child: Text(  
            i.toString()
          ),),
          width: 40,
        );
        output.add(currentPageText);
      } else {
        final btPage = ElevatedButton(
          child: Text(
            i.toString()
          ),
          onPressed: (){
            getSystemLog(i, defaultPageSize).then((value){
            setState(() {
              logs = value.eventList;
              countPage = value.totalPage;
              currentPage = value.currentPage;
            });
          });
          },
        );
        output.add(btPage);
      }
      output.add(SizedBox(width: defaultHalfPadding));
    }
    return output;
    // [
    //           ElevatedButton(onPressed: (){}, child: Text("1")),
    //           ElevatedButton(onPressed: (){}, child: Text("2")),
    //           ElevatedButton(onPressed: (){}, child: Text("3")),
    //           Text("..."),
    //           ElevatedButton(onPressed: (){}, child: Text("3")),
    //         ],
  }

  @override
  Widget build(BuildContext context) {
    final logList = logs;
    // final logList = logs.isEmpty ? sampleLogList : logs;
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
                    logList.length,
                    (index){
                      final log = logList[index];
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
            children: createPageButton()
          )
        ],
      ),
    );
  }
}