import 'dart:async';

import 'package:admin/api/systemalarm.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class EventListScreen extends StatefulWidget {
  const EventListScreen({ Key? key }) : super(key: key);

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}


class _EventListScreenState extends State<EventListScreen> {
  Timer? timerQueryData;
  List<Event> eventList = [];
  final defaultPageSize = 10;
  int currentPage = 1;
  int countPage = 1;
  
  void getDataEvents(){
    getSystemAlarm(currentPage, defaultPageSize).then((value){
      setState(() {
        eventList = value.eventList;
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
      if (userControl.currentStackIndex == 2){
        getDataEvents();
      }
    });
    getDataEvents();
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
            getSystemAlarm(i, defaultPageSize).then((value){
            setState(() {
              eventList = value.eventList;
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
                  eventList.length,
                  (index){
                    final event = eventList[index];
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
          Row(
            children: createPageButton()
          )
        ],
      ),
    );
  }
}