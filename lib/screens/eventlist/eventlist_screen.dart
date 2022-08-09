import 'dart:async';

import 'package:admin/api/systemalarm.dart';
import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';


class EventListScreen extends StatefulWidget {
  const EventListScreen({ Key? key }) : super(key: key);

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}


class _EventListScreenState extends State<EventListScreen> {
  List<Event> eventList = [];
  int defaultPageSize = 30;
  int currentPage = 1;
  int countPage = 1;
  
  void getSystemEventThenUpdate(){
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
    final userControl = UserControl();
    userControl.addStackIndexChangeListener((index){
      if (index == eventListIndex){
        getSystemEventThenUpdate();
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
          child: Text(i.toString()),
          onPressed: (){
            currentPage = i;
            getSystemEventThenUpdate();
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
          getSystemEventThenUpdate();
        }
      )
    );
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
                  columnSpacing: defaultPadding,
                  border: defaultTableBorder,
                  headingRowColor: defaultHeaderBackground,
                  showCheckboxColumn: false,
                  columns: ['STT', 'Mức cảnh báo', 'Thiết bị', 'Cấu hình tạo', 'Thông báo', 'Thời gian', 'Trạng thái']
                    .map((e) => DataColumn(label: Text(e, style: defaultTableHeaderStyle))).toList(),
                  rows: List.generate(
                    eventList.length,
                    (index){
                      final event = eventList[index];
                      return DataRow(
                        cells: [
                          DataCell(
                            Container(width: 30, child: Text(event.num.toString()))
                          ),
                          DataCell(Text(
                            levelToString(event.level),
                            style: TextStyle(
                              color: levelToColor(event.level),
                            ),
                          )),
                          DataCell(Text(event.device)),
                          DataCell(Text(event.ruleName)),
                          DataCell(Text(event.message)),
                          DataCell(Text(event.time.toString())),
                          DataCell(
                            Row(
                              children: [
                                Text(event.readed ? 'Đã đọc' : 'Chưa đọc'),
                                SizedBox(width: defaultPadding),
                                if (!event.readed)
                                  SizedBox(
                                    width: 60, height: 32,
                                    child: TextButton(
                                      child: Icon(Icons.check),
                                      onPressed: (){
                                        setState(() {
                                          eventList[index].readed = true;
                                        });
                                        markReadedSystemAlarm(event.id);
                                      },
                                    )
                                  )
                              ],
                            )
                          )
                        ],
                      );
                    },
                  ),
                ),
              )
            )
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: createPageButton()
          )
        ],
      ),
    );
  }
}