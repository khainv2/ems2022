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