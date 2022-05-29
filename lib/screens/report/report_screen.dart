import 'package:admin/models/device.dart';
import 'package:admin/models/msblistsample.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';

import '../../common.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({ Key? key }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}
class _ReportScreenState extends State<ReportScreen> {
  String _deviceSerial = '';
  String? textData;
  DateTime timeSearch = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  
  @override 
  void initState(){
    super.initState();
  }

  Widget deviceListDropDown(){
    final multimeters = getDeviceListByType(DeviceType.Multimeter);
    final items = multimeters.map((e) => DropdownMenuItem(
      child: Text(e.name),
      value: e.getSerial()
    )).toList();
    if (_deviceSerial.isEmpty && items.isNotEmpty){
      _deviceSerial = multimeters.first.getSerial();
    }
    return Container(
      width: 200,
      height: 40,
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
            elevation: 62,
            style: const TextStyle(color: primaryColor),
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
              // getEnergyTrendAndUpdate();
            },
          )
        ),
      ),
    );
  }

  Widget dateTimeButton(){
    return Container(
      width: 200,
      height: 40,
      child: OutlinedButton(
        child: Row(
          children: [
            Icon(Icons.calendar_month),
            Text(fullDateFormatter.format(timeSearch))
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
              // getHistoryData();
            }
          });
        },
      )
    );
  }

  
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
          Row (
            children: [
              SizedBox(child: Text('Chọn thiết bị')),
              SizedBox(width: defaultHalfPadding,),
              deviceListDropDown(),
              SizedBox(width: defaultPadding,),
              SizedBox(child: Text('Chọn ngày')),
              SizedBox(width: defaultHalfPadding,),
              dateTimeButton(),
            ]
          ), 
          SizedBox(height: defaultPadding),
          Expanded(
            child: Container()
          )
        ],
      ),
    );
  }
}