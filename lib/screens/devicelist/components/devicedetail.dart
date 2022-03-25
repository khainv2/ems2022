import 'package:admin/models/msb.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';


class ParamInfoCart extends StatelessWidget {
  const ParamInfoCart({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultHalfPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultHalfPadding),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}

class DeviceDetail extends StatelessWidget {
  final Device device;
  const DeviceDetail({ Key? key, required this.device }) : super(key: key);
  AppBar appBar(BuildContext context){
    return AppBar(
      title: Text("${device.name} - ${device.model} [${device.address ?? device.modbusAddress ?? ""}]"),
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.update),
            onPressed: () => {
              
            },
          ),
      ],
    );
  }

  Widget paramRow(String key1, String value1, String key2, String value2){
    return Row(
      children: [
        Expanded(
          child: ParamInfoCart(
            title: key1,
            value: value1,
          ),
        ),
        SizedBox(width: defaultHalfPadding),
        if (key2.isEmpty)
          Expanded(
            child: Container(),
          )
        else 
          Expanded(
            child: ParamInfoCart(
              title: key2,
              value: value2,
            ),
          )
        
        ,
      ],
    );
  }

  Widget listParam(BuildContext context){
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dữ liệu thời gian thực",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: Column(
              children: [
                paramRow("Ua", "1.234V", "Ia", "2.8A"),
                SizedBox(height: defaultHalfPadding),
                paramRow("Ub", "3.282V", "Ib", "3.2A"),
                SizedBox(height: defaultHalfPadding),
                paramRow("Uc", "2.234V", "Ic", "2.2A"),
                SizedBox(height: defaultHalfPadding),
                paramRow("f", "50Hz", "P", "42W"),
                SizedBox(height: defaultHalfPadding),
                paramRow("Q", "22VAR", "S", "12VA"),
                SizedBox(height: defaultHalfPadding),
                if (device.name.contains("ACB"))
                  paramRow("Pf", "22", "Temperature", "12°C")
                else 
                  paramRow("Pf", "22", "Harmonic", "12"),
                SizedBox(height: defaultHalfPadding),
                if (device.name.contains("ACB"))
                  paramRow("Operation count", "12", "Trip count", "3"),
                SizedBox(height: defaultHalfPadding),
                if (device.name.contains("ACB"))
                  paramRow("Time operation", "23s", "Time max temp", "25s"),
                SizedBox(height: defaultHalfPadding),
                if (device.name.contains("ACB"))
                  paramRow("Operation Time", "12s", "Trip", "ON"), 
              ],
            )
          ),
          // SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(child: Container(),),
              
              Text(
                "Thời gian cập nhật: 15 phút trước",
                style: TextStyle(color: Colors.white54),
              )
            ],
          )

        ],
      )
    );
    
  }

  Widget tabHistory(BuildContext context){
    final now = DateTime.now();
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: "1",
                items: [
                  DropdownMenuItem(
                    value: "1",
                    child: Text("Ua"),
                  ),
                  DropdownMenuItem(
                    value: "2",
                    child: Text("Ub"),
                  ),
                  DropdownMenuItem(
                    value: "3",
                    child: Text("Uc"),
                  ),
                ],
                onChanged: (val){},
              ),
              Expanded(child: Container()),
              OutlinedButton(
                
                child: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Text("20/03/2022")
                  ],
                ),
                onPressed: (){
                  showDatePicker(context: context, 
                                initialDate: DateTime.now(), 
                                firstDate: DateTime(2015, 8), 
                                lastDate: DateTime(2101));
                },
              )

            ],
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(1, 20),
                      FlSpot(2, 20),
                      FlSpot(3, 40),
                      FlSpot(4, 30),
                      FlSpot(5, 60),
                      FlSpot(6, 40),
                      FlSpot(7, 35),
                    ]
                  )
                ]
                // read about it in the LineChartData section
              ),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            )
          ),
        ],
      )
    );
  }

  Widget tabAlarmInfo(){
    return Column(
      children: [
        SizedBox(height: 60,),
        Icon(Icons.do_not_disturb_off_outlined),
        SizedBox(height: defaultPadding),
        Text("Chưa có dữ liệu")
      ],
    );
  }

  Widget moreInfoWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              width: 400,
              child: TabBar(
                  tabs: [
                    Tab(text: "Lịch sử"),
                    Tab(text: "Thông tin cảnh báo"),
                  ],
                ),
            ),
            Expanded(
              child: TabBarView(
              children: [
                tabHistory(context),
                tabAlarmInfo()
              ],
            ),
            )
          ],
        )
      )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1, 
                    child: listParam(context)
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 2, 
                    child: moreInfoWidget(context)
                  ),
                ],
              )
            )
          ],
        )
      ),
    );
  }
}

