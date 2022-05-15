import 'package:admin/constants.dart';
import 'package:admin/screens/energy_management/components/chain_analysis.dart';
import 'package:admin/screens/energy_management/components/daily_average_load.dart';
import 'package:admin/screens/energy_management/components/load_trend.dart';
import 'package:admin/screens/energy_management/components/peak_consumption.dart';
import 'package:flutter/material.dart';

class EnergyManagementScreen extends StatefulWidget {
  const EnergyManagementScreen({ Key? key }) : super(key: key);

  @override
  State<EnergyManagementScreen> createState() => _EnergyManagementScreenState();
}

class _EnergyManagementScreenState extends State<EnergyManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row (
              children: [
                Text('Chọn thiết bị'),
                SizedBox(width: defaultPadding,),
                DropdownButton<String>(
                  value: "1",
                  items: [
                    DropdownMenuItem(
                      value: "1",
                      child: Text("Multimeter 1"),
                    ),
                    DropdownMenuItem(
                      value: "2",
                      child: Text("Multimeter 2"),
                    ),
                    DropdownMenuItem(
                      value: "3",
                      child: Text("Multimeter 3"),
                    ),
                    DropdownMenuItem(
                      value: "4",
                      child: Text("Multimeter 4"),
                    ),
                  ],
                  onChanged: (val){},
                ),
              ],
            )
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: DailyAverageLoad()
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 2, 
                  child: PeakConsumption()
                )
              ],
            )
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ChainAnalysis()
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 5, 
                  child: LoadTrend()
                )
              ],
            )
          ),
        ],
      )
    );
  }
}