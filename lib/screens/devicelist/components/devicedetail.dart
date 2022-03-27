import 'package:admin/models/msb.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

final multimeterSampleValue = {
  "U12": "23.289V",
  "U23": "29.282V",
  "U31": "1.389V",
  "U1": "2.823V",
  "U2": "4.832V",
  "U3": "9.483V",
  "I1": "1.2A",
  "I2": "3.2A",
  "I3": "4.2A",
  "In": "2A",
  "F": "50Hz",
  "P": "29W",
  "Q": "3VAR",
  "S": "40VA",
  "Pf": "44",
  "THD-U12": "70%",
  "THD-U23": "80%",
  "THD-U31": "75%",
  "THD-U1": "70%",
  "THD-U2": "80%",
  "THD-U3": "75%",
  "THD-I1": "70%",
  "THD-I2": "80%",
  "THD-I3": "75%",
  "THD-In": "40%",
};

final acbSampleValue = {
  "I1": "1.2A",
  "I2": "3.2A",
  "I3": "4.2A",
  "U1": "2.823V",
  "U2": "4.832V",
  "U3": "9.483V",
  "P": "29W",
  "Q": "3VAR",
  "S": "40VA",
  "Pf": "44",
  "F": "40Hz",
  "Temperature": "°C",
  "Operation count": "12",
  "Trip count": "22",
  "Time last operation": "23s",
  "Time max temperature": "22s",
  "Operation time": "44s",
  "Trip": "ON"
};

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
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultHalfPadding,
        bottom: defaultHalfPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultHalfPadding),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: accentColor
            )
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
            onPressed: () => {},
          ),
      ],
    );
  }

  Widget paramRow(String key1, String value1, String key2, String value2, String key3, String value3){
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
        SizedBox(width: defaultHalfPadding),
        if (key3.isEmpty)
          Expanded(
            child: Container(),
          )
        else 
          Expanded(
            child: ParamInfoCart(
              title: key3,
              value: value3,
            ),
          )
        ,
      ],
    );
  }

  Widget listParam(BuildContext context){
    final sampleValue = device.name.contains("ACB") ? acbSampleValue : multimeterSampleValue;
    final keys = sampleValue.keys.toList();
    List<Widget> paramRows = [];
    for (int i = 0; i < keys.length; i+=3){
      final k1 = keys[i];
      final v1 = sampleValue[k1]!;
      final k2 = i + 1 >= keys.length ? "" : keys[i + 1];
      final v2 = i + 1 >= keys.length ? "" : sampleValue[k2]!;
      final k3 = i + 2 >= keys.length ? "" : keys[i + 2];
      final v3 = i + 2 >= keys.length ? "" :sampleValue[k3]!;
      paramRows.add(paramRow(k1, v1, k2, v2, k3, v3));
      paramRows.add(SizedBox(height: defaultHalfPadding));
    }
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
              children: paramRows
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
                    flex: 3, 
                    child: listParam(context)
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 5, 
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

