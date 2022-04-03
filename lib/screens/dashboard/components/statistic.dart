import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Statistic extends StatelessWidget {
  const Statistic({
    Key? key,
  }) : super(key: key);

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
            "Thống kê năng lượng",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultHalfPadding),
          Row(
            children: [
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: (){}, 
                child: Text("7 ngày")
              ),
              SizedBox(width: defaultHalfPadding),
              OutlinedButton(
                onPressed: (){}, 
                child: Text("Chi tiết")
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: Container(

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
            )
          ),
          SizedBox(height: defaultHalfPadding),
        ],
      ),
    );
  }
}
