import 'package:admin/api/energy_trend.dart';
import 'package:admin/common.dart';
import 'package:admin/models/energyinfo.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class DailyAverageLoadChart extends StatefulWidget {
  final EnergyTrendTotal energyTrendTotal;
  const DailyAverageLoadChart({ Key? key, required this.energyTrendTotal }) : super(key: key);

  @override
  State<DailyAverageLoadChart> createState() => _DailyAverageLoadChartState();
}

class _DailyAverageLoadChartState extends State<DailyAverageLoadChart> {
  @override
  Widget build(BuildContext context) {
    List<DailyEnergyInfo> list = [];
    for (int i = 0; i < 23; i++){
      list.add(sampleDailyEnergy[i]);
    }
    List<BarChartGroupData> barDataList = [];
    if (widget.energyTrendTotal.success){
      final day = widget.energyTrendTotal.day!;
      final paramList = day.getListDual();
      for (final h in paramList){
        final b = BarChartGroupData(
          x: h.time,
          barRods: [
            BarChartRodData(
              toY: h.beforeValue, 
              width: 10, 
              colors: [accentColor]
            ),
            BarChartRodData(
              toY: h.currentValue, //e.val - e.hour + 12, 
              width: 10, 
              colors: [primaryColor]
            )
          ]
        );
        barDataList.add(b);
      }
    }

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
        barGroups: barDataList
      )
    );
  
  }
}

class DailyAverageLoad extends StatefulWidget {
  final EnergyTrendTotal energyTrendTotal;
  const DailyAverageLoad({ Key? key, required this.energyTrendTotal }) : super(key: key);

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
            child: DailyAverageLoadChart(energyTrendTotal: widget.energyTrendTotal,)
          )
        ],
      ),
    );
  }
}