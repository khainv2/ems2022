import 'dart:async';

import 'package:admin/api/systemlog.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

import '../../common.dart';


class LogListScreen extends StatefulWidget {
  const LogListScreen({ Key? key }) : super(key: key);

  @override
  State<LogListScreen> createState() => _LogListScreenState();
}

class _LogListScreenState extends State<LogListScreen> {
  // Timer? timerQueryData;
  List<Log> logs = [];
  int defaultPageSize = 10;
  int currentPage = 1;
  int countPage = 1;
  
  void getDataLogAndUpdate(){
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
    final userControl = UserControl();
    userControl.addStackIndexChangeListener((index){
      if (index == logListIndex){
        getDataLogAndUpdate();
      }
    });
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
        if (i > 2 && i < countPage - 1 && (i - currentPage).abs() > 2){
          continue;
        }
        final btPage = ElevatedButton(
          child: Text(
            i.toString()
          ),
          onPressed: (){
            currentPage = i;
            getDataLogAndUpdate();
          },
        );
        output.add(btPage);
      }
      output.add(SizedBox(width: defaultHalfPadding));
    }
    output.add(Expanded(child: Container()));
    output.add(Text('Số trang'));
    output.add(SizedBox(width: defaultPadding));
    output.add(
      DropdownButton<int>(
        value: defaultPageSize,
        items: [10, 30, 50, 100].map((e) 
          => DropdownMenuItem<int>(
            child: Text(e.toString()), 
            value: e)
          ).toList(),
        onChanged: (val){
          if (val == null) return;
          defaultPageSize = val;
          currentPage = 1;
          getDataLogAndUpdate();
        }
      )
    );
    return output;
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
          SizedBox(height: defaultPadding),
          Expanded(
            child: SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                child: DataTable(
                  headingRowHeight: Responsive.isMobile(context) ? 36 : 48,
                  dataRowHeight: Responsive.isMobile(context) ? 36 : 48,
                  headingRowColor: defaultHeaderBackground,
                  columnSpacing: defaultPadding,
                  border: defaultTableBorder,
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                      label: Text("STT", style: defaultTableHeaderStyle),
                    ),
                    DataColumn(
                      label: Text("Loại", style: defaultTableHeaderStyle),
                    ),
                    DataColumn(
                      label: Text("Thông báo", style: defaultTableHeaderStyle),
                    ),
                    DataColumn(
                      label: Text("Thời gian", style: defaultTableHeaderStyle),
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