import 'package:admin/constants.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class DailyAverageLoadChart extends StatefulWidget {
  const DailyAverageLoadChart({ Key? key }) : super(key: key);

  @override
  State<DailyAverageLoadChart> createState() => _DailyAverageLoadChartState();
}



class _DailyAverageLoadChartState extends State<DailyAverageLoadChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(
          border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          )
        ),
        groupsSpace: 6,
        barGroups: sampleDailyEnergy.map((e) => BarChartGroupData(
          x: e.hour, 
          barRods: [
            BarChartRodData(
              toY: e.val, 
              width: 10, 
              colors: [accentColor]
            ),
            BarChartRodData(
              toY: e.val - e.hour + 12, 
              width: 10, 
              colors: [primaryColor]
            )
          ]
        )).toList(),
      )
    );
  
  }
}

class DailyAverageLoad extends StatefulWidget {
  const DailyAverageLoad({ Key? key }) : super(key: key);

  @override
  State<DailyAverageLoad> createState() => _DailyAverageLoadState();
}

class _DailyAverageLoadState extends State<DailyAverageLoad> {
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
            "Tải trung bình hằng ngày",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: DailyAverageLoadChart()
          )
        ],
      ),
    );
  }
}