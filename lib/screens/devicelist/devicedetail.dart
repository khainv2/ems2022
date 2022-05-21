import 'dart:convert';

import 'package:admin/api/history.dart';
import 'package:admin/api/realtime.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/screens/devicelist/components/paraminfocart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

import 'dart:async';


class DeviceDetail extends StatefulWidget {
  final Device device;
  const DeviceDetail({ Key? key, required this.device }) : super(key: key);

  @override
  State<DeviceDetail> createState() => _DeviceDetailState();
}

class _DeviceDetailState extends State<DeviceDetail> {
  Device? deviceInfo;
  String selectionParam = '';
  DateTime timeSearch = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<HistoryParam> _historyParam = [];
  Timer? timerQueryData;
  final dateFormatter = DateFormat('dd/MM/yyyy');

  void getRealtimeData(){
    print('get serial from ${widget.device.getSerial()}');
    getRealtime(widget.device.getSerial()).then((value){
      setState(() {
        deviceInfo = value;
        if (deviceInfo != null){
          
          if (deviceInfo!.realtimeParam.length > 0 && selectionParam.isEmpty){
            if (deviceInfo!.realtimeParam.containsKey('U1')){
              selectionParam = 'U1';
            }
            getHistoryData();
          }
        }
      });
    });
  }

  void getHistoryData(){
    final timeSearchBegin = timeSearch.millisecondsSinceEpoch ~/ 1000;
    final timeSearchEnd = timeSearchBegin + 86400;
    if (selectionParam.isEmpty)
      return;
    getHistory(widget.device.getSerial(), selectionParam, timeSearchBegin, timeSearchEnd).then((value){
      setState(() {
        _historyParam = value;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    const oneSec = Duration(seconds: 3);
    timerQueryData = Timer.periodic(oneSec, (Timer t) => getRealtimeData());   
    getRealtimeData();
  }

  @override
  void dispose(){
    super.dispose();
    if (timerQueryData != null){
      timerQueryData!.cancel();
    }
  }

  AppBar appBar(BuildContext context){
    return AppBar(
      title: Text("${widget.device.name} [${widget.device.address}]"),
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
          onPressed: () => getRealtimeData,
        ),
      ],
    );
  }

  Widget paramColumn(String key1, String value1, String key2, String value2, String key3, String value3){
    return Column(
      children: [
        Expanded(
          child: ParamInfoCart(
            title: key1,
            value: value1,
          ),
        ),
        SizedBox(height: defaultHalfPadding),
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
        SizedBox(height: defaultHalfPadding),
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
    var sampleValue = widget.device.name.contains("ACB") ? acbSampleValue : multimeterSampleValue;
    if (deviceInfo != null){
      sampleValue.clear();
      for (final k in deviceInfo!.realtimeParam.keys){
        final v = deviceInfo!.realtimeParam[k];
        sampleValue[k] = v!.getFullValue();
      }
    }

    final keys = sampleValue.keys.toList();

    List<Widget> paramColumns = [];
    for (int i = 0; i < keys.length; i+=3){
      final k1 = keys[i];
      final v1 = sampleValue[k1]!;
      final k2 = i + 1 >= keys.length ? "" : keys[i + 1];
      final v2 = i + 1 >= keys.length ? "" : sampleValue[k2]!;
      final k3 = i + 2 >= keys.length ? "" : keys[i + 2];
      final v3 = i + 2 >= keys.length ? "" :sampleValue[k3]!;
      if (deviceInfo == null)
        paramColumns.add(paramColumn(k1, '0 ${getMultimeterUnit(k1)}', k2, '0 ${getMultimeterUnit(k2)}', k3, '0 ${getMultimeterUnit(k3)}'));
      else 
        paramColumns.add(paramColumn(k1, v1, k2, v2, k3, v3));
      paramColumns.add(SizedBox(width: defaultHalfPadding));
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
            child: Row(
              children: paramColumns
            )
          ),

        ],
      )
    );
  }

  Widget paramHistoryChart(){
    // Tìm giá trị nhỏ nhất & lớn nhất trên biểu đồ
    int? minx, maxx;
    double? miny, maxy;
    if (_historyParam.length > 0){
      minx = _historyParam[0].time;
      maxx = _historyParam[0].time;
      miny = _historyParam[0].value;
      maxy = _historyParam[0].value;
      for (final p in _historyParam){
        final y = p.value, x = p.time;
        if (minx! > x) minx = x;
        if (maxx! < x) maxx = x;
        if (miny! > y) miny = y;
        if (maxy! < y) maxy = y;
      }
      final scalex = maxx! - minx!;
      final scaley = maxy! - miny!;
      // Làm tròn giá trị minx đến phút, maxx tròn 1 giờ, 
      if (scalex > 0){
        minx = minx - (minx % 3600);
        if (minx % 60 > 0) minx -= (minx % 60);
        maxx = minx + 86400 - 60;
      }
      // Nới rộng khoảng cách của miny và maxy, làm tròn đến giá trị thập phân
      if (scaley > 0){
        final nextScale = scaley < 10 ? (scaley * 2) : (scaley * 1.5);
        final center = (maxy + miny) / 2;
        miny = (center - (nextScale / 2)).floorToDouble();
        maxy = (center + (nextScale / 2)).ceilToDouble();
      }
    }

    List<FlSpot> spots = [];
    for (int i = 0; i < _historyParam.length; i++){
      final historyItem = _historyParam[i];
      spots.add(FlSpot(historyItem.time.toDouble(), historyItem.value));
      if (i < _historyParam.length - 1){
        if (_historyParam[i + 1].time - _historyParam[i].time > 600){
          spots.add(FlSpot.nullSpot);
        }
      }
    }
    // if (_historyParam.length > 0){
    //   // spots.add(FlSpot.nullSpot);
    //   final lastTimeOfDay = _historyParam[0].time + 86400;
    //   spots.add(FlSpot(lastTimeOfDay.toDouble(), 0));
    // }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            dotData: FlDotData(show: false),
          )
        ],
        minX: minx == null ? null : minx.toDouble(),
        maxX: maxx == null ? null : maxx.toDouble(),
        minY: miny,
        maxY: maxy,
        lineTouchData: LineTouchData(
          enabled: false,
          handleBuiltInTouches: false,
          getTouchedSpotIndicator: (barData, spotIndex) => [],
        ),
        gridData: FlGridData(
          show: true,
          verticalInterval: 3600,
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value){
              return TextStyle(
                fontSize: 10,
              );
            },
            interval: 3600,
            
            getTitles: (value){
              final formatter = DateFormat('HH:mm');
              final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000);
              return formatter.format(dateTime);
            },
            checkToShowTitle: (double minValue, double maxValue, SideTitles sideTitles, double appliedInterval, double value){
              if (value == minValue || value == maxValue){
                return true;
              } else {
                return true;
              }
            },
            reservedSize: 38,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value){
              return TextStyle(
                fontSize: 10,
              );
            },
            reservedSize: 60,
          ),
        ),
        // read about it in the LineChartData section
      ),
      
      swapAnimationDuration: Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear
    );
  }

  Widget tabHistory(BuildContext context){
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              if (deviceInfo != null)
                Text('Chọn tham số'),
              if (deviceInfo != null)
                SizedBox(width: defaultPadding,),
              if (deviceInfo != null)
                DropdownButton<String>(
                  value: selectionParam,
                  items: deviceInfo!.realtimeParam.keys.map((e) 
                    => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (val){
                    setState(() {
                      selectionParam = val!;
                    });
                    getHistoryData();
                  },
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  
                  underline: SizedBox(),
                  alignment: Alignment.center,
                ),
              
              SizedBox(width: defaultPadding,),
              Text('Chọn ngày'),
              SizedBox(width: defaultPadding,),
              OutlinedButton(
                
                child: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Text(dateFormatter.format(timeSearch))
                  ],
                ),
                onPressed: (){
                  showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2015, 8), 
                    lastDate: DateTime(2101),
                    cancelText: 'Bỏ qua',
                    confirmText: 'Xác nhận',
                    currentDate: timeSearch,
                    locale: Locale('vi', 'VN')
                  ).then((value){
                    if (value != null){
                      timeSearch = DateTime(
                        value.year,
                        value.month,
                        value.day,
                      );
                      getHistoryData();
                    }
                  });
                },
              ),
              Expanded(child: Container()),
            ],
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: paramHistoryChart()
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
        margin: EdgeInsets.all(defaultPadding),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return [
                    Container(
                      child: listParam(context),
                      height: 290,
                    ),
                    SizedBox(height: defaultPadding),
                    Container(
                      child: moreInfoWidget(context),
                      height: 800,
                    )
                  ][index];
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      )
    );
  }
}

