import 'package:flutter/material.dart';

// Mô tả các loại tham số khác nhau của device 

class DeviceParam {
  String name;
  double value;
  String unit;
  DeviceParam(this.name, this.value, this.unit);
  String getFullValue(){ 
    if ((name == 'Q' || name == 'P' || name == 'S' || name == 'E') && value.abs() >= 1000){
      final kVal = value / 1000;
      return '${kVal.toStringAsFixed(2)} k$unit';
    }
    return "$value $unit"; 
  }
}

// Mô tả 2 loại device khác nhau
enum DeviceType {
  ACB, Multimeter
}

enum DeviceState {
  None, Online, Offline, Alarm, Inactive, Error
}

const int ACBStatusInactive = 0;
const int ACBStatusOpen = 1;
const int ACBStatusClose = 2;
const int ACBStatusTrip = 3;


const Map<String,DeviceParam> defaultRealtimeParam = {};
  
  /// Mô tả một thiết bị cùng trạng thái đi kèm
class Device {
  String name;
  DeviceType type;
  String address;
  String note;
  DeviceState state;
  // Key is name of device param
  Map<String, DeviceParam> realtimeParam;
  
  Device({
    required this.name, 
    required this.type, 
    this.address = "", 
    this.note = "",
    this.state = DeviceState.Offline,
    this.realtimeParam = defaultRealtimeParam,
  });

  String stateStr(){
    switch (state){
      case DeviceState.Online: return "Bật";
      case DeviceState.Offline: return "Tắt";
      case DeviceState.Alarm: return 'Cảnh báo';
      case DeviceState.Inactive: return 'Không hoạt động';
      case DeviceState.Error: return 'Lỗi';
      default: return '';
    }
  }
  Color stateColor(){
    switch (state){
    case DeviceState.Online: return Color(0xff00cc00);
    case DeviceState.Offline: return Color(0xffcc0000);
    case DeviceState.Alarm: return Color.fromARGB(255, 249, 220, 59);
    case DeviceState.Inactive: return Color.fromARGB(255, 247, 149, 129);
    case DeviceState.Error: return Color(0xFFcc0000);
    default: return Colors.transparent;
  }
  }

  String getSerial(){
    if (type == DeviceType.ACB){
      return "ACB$name".replaceAll('.', '_');
    } else {
      var n = name.split(' ').last;
      if (n.length == 1) n = '0$n';
      return 'MM$n';
    }
  }

  static DeviceType getTypeFromSerial(String serial){
    if (serial.contains('ACB')){
      return DeviceType.ACB;
    } else {
      return DeviceType.Multimeter;
    }
  }
  
  static String getNameFromSerial(String serial){
    if (serial.contains('ACB')){
      return serial.replaceAll('ACB', '');
    } else {
      return serial.replaceAll('MM', 'Multimeter ').replaceAll(' 0', ' ');
    }
  }
  
}

class DeviceTable {
  // Key: Q1.1, Q1.2,...
  Map<String, Device> acbDevices;
  // Key: Multimeter 1, Multimeter 2
  Map<String, Device> multimeterDevices;
  DeviceTable(this.acbDevices, this.multimeterDevices);
}