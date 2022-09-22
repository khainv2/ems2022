import 'package:admin/api/energy_trend.dart';
import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msblistsample.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/energy_management/components/chain_analysis.dart';
import 'package:admin/screens/energy_management/components/daily_average_load.dart';
import 'package:admin/screens/energy_management/components/load_trend.dart';
import 'package:admin/screens/energy_management/components/peak_consumption.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class EnergyManagementScreen extends StatefulWidget {
  const EnergyManagementScreen({ Key? key }) : super(key: key);

  @override
  State<EnergyManagementScreen> createState() => _EnergyManagementScreenState();
}

class _EnergyManagementScreenState extends State<EnergyManagementScreen> {
  String _deviceSerial = '';
  EnergyTrendTotal _energyTrend = EnergyTrendTotal(success: false);

  void getEnergyTrendAndUpdate(){
    if (_deviceSerial.isEmpty)
      return;
    getEnergyTrendTotal(_deviceSerial, DateTime.now()).then((value){
      print('Get energy trend total result ${value.success}');
      setState(() {
        _energyTrend = value;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    final userControl = UserControl();
    userControl.addStackIndexChangeListener((index){
      if (index == energyManagementIndex){
        getEnergyTrendAndUpdate();
      }
    });
  }

  Widget deviceListDropDown(){
    final multimeters = getDeviceListByType(DeviceType.Multimeter);
    final items = multimeters.map((e) => DropdownMenuItem(
      child: Text(e.name + ' - ' + e.note
                                    .replaceAll('Giám sát điện năng cho', '')
                                    .replaceAll('Giám sát điện năng', '')
                                    .replaceAll('giám sát điện năng cho', '')),
      value: e.getSerial()
    )).toList();
    if (_deviceSerial.isEmpty && items.isNotEmpty){
      _deviceSerial = multimeters.first.getSerial();
    }
    return Row (
      children: [
        SizedBox(width: 150, child: Text('Chọn thiết bị')),
        SizedBox(width: defaultPadding,),
        Container(
          // width: 250,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0, 
                style: BorderStyle.solid,
                color: Colors.white54
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                elevation: 42,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                value: _deviceSerial,
                items: items,
                onChanged: (val){
                  setState(() {
                    if (val == null) 
                      return;
                    _deviceSerial = val;
                  });
                  getEnergyTrendAndUpdate();
                },
              )
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    if (isMobile){
      return Expanded(
        child:  InteractiveViewer(
          constrained: false,
          scaleEnabled: true,
          minScale: 0.1,
          maxScale: 5,
          // panEnabled: false,
          child: Container(
            width: 1000,
            height: 1500,
            child: Column(
              children: [
                deviceListDropDown(),
                SizedBox(height: defaultHalfPadding),
                SizedBox(width: 1000, height: 300, child: DailyAverageLoad(energyTrendTotal: _energyTrend)),
                SizedBox(width: 1000, height: 300, child: PeakConsumption(energyTrendTotal: _energyTrend,)),
                SizedBox(width: 1000, height: 300, child: ChainAnalysis(energyTrendTotal: _energyTrend)),
                SizedBox(width: 1000, height: 300, child: LoadTrend(energyTrendTotal: _energyTrend))
              ],
            )
          )
        )
      );
    } else 
    return SafeArea(
      child: Column(
        children: [
          deviceListDropDown(),
          SizedBox(height: defaultHalfPadding),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: DailyAverageLoad(
                    energyTrendTotal: _energyTrend
                  )
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 2, 
                  child: PeakConsumption(energyTrendTotal: _energyTrend,)
                )
              ],
            )
          ),
          SizedBox(height: defaultHalfPadding),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ChainAnalysis(energyTrendTotal: _energyTrend)
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 5, 
                  child: LoadTrend(energyTrendTotal: _energyTrend)
                )
              ],
            )
          ),
        ],
      )
    );
  }
}