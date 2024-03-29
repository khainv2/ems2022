import 'package:admin/api/energy_trend.dart';
import 'package:admin/common.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class LoadTrendChart extends StatefulWidget {
  final bool isDaily;
  final EnergyTrendTotal energyTrendTotal;
  
  const LoadTrendChart({ Key? key, required this.isDaily, required this.energyTrendTotal }) : super(key: key);

  @override
  State<LoadTrendChart> createState() => _LoadTrendChartState();
}

class _LoadTrendChartState extends State<LoadTrendChart> {

  
  @override
  Widget build(BuildContext context) {
    if (widget.energyTrendTotal.success){
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
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
              checkToShowTitle: (double minValue, double maxValue, SideTitles sideTitles, double appliedInterval, double value){
                if (value == minValue || value == maxValue){
                  return false;
                } else {
                  return true;
                }
              },
            ),
            topTitles: SideTitles(
              showTitles: false,
            )
            
          ),
          barGroups: widget.isDaily ? widget.energyTrendTotal.month!.currentList.map((e){
            return BarChartGroupData(
              x: e.time, 
              barRods: [
                BarChartRodData(
                  toY: e.value, //e.val, 
                  width: 10, 
                  colors: [primaryColor]
                ),
              ]
            );
          }).toList() : widget.energyTrendTotal.year!.currentList.map((e){
            return BarChartGroupData(
              x: e.time, 
              barRods: [
                BarChartRodData(
                  toY: e.value, //e.val, 
                  width: 10, 
                  colors: [primaryColor]
                ),
              ]
            );
          }).toList()

        )
      );
    } else {
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
          barGroups: 
          widget.isDaily ?
          sampleDailyEnergy.map((e) => BarChartGroupData(
            x: e.hour, 
            barRods: [
              BarChartRodData(
                toY: 0, //e.val, 
                width: 10, 
                colors: [primaryColor]
              ),
            ]
          )).toList() : 
          sampleMonthlyEnergy.map((e) => BarChartGroupData(
            x: e.day, 
            barRods: [
              BarChartRodData(
                toY: 0, //e.val, 
                width: 10, 
                colors: [primaryColor]
              ),
            ]
          )).toList(),
        )
      );
    }
  }
}

class LoadTrend extends StatefulWidget {
  
  final EnergyTrendTotal energyTrendTotal;
  const LoadTrend({ Key? key, required this.energyTrendTotal }) : super(key: key);

  @override
  State<LoadTrend> createState() => _LoadTrendState();
}

class _LoadTrendState extends State<LoadTrend> {
  bool _isDaily = true;

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
            "Xu hướng",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(children: [
            Expanded(child: Container()),
            _isDaily ? ElevatedButton(
              onPressed: (){ setState(() { _isDaily = false; }); }, 
              child: Text("Ngày")
            ) : OutlinedButton(
              onPressed: (){ setState(() { _isDaily = true; }); }, 
              child: Text("Ngày")
            ),
            SizedBox(width: defaultHalfPadding),
            _isDaily ?
            OutlinedButton(
              onPressed: (){ setState(() { _isDaily = false; }); }, 
              child: Text("Tháng")
            ) : ElevatedButton(
              onPressed: (){ setState(() { _isDaily = true; }); }, 
              child: Text("Tháng")
            ),
          ],),
          SizedBox(height: defaultPadding),
          Expanded(
            child: LoadTrendChart(isDaily: _isDaily, energyTrendTotal: widget.energyTrendTotal,)
          )
        ],
      ),
    );
  }
}