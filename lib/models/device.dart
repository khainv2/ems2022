
// Mô tả các loại tham số khác nhau của device 
class DeviceParam {
  String name;
  double value;
  String unit;
  DeviceParam(this.name, this.value, this.unit);
  String getFullValue(){ return "$value $unit"; }
}

// Mô tả 2 loại device khác nhau
enum DeviceType {
  ACB, Multimeter
}

enum DeviceState {
  None, Online, Offline, Alarm, Inactive, Error
}

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

  String getSerial(){
    if (type == DeviceType.ACB){
      return "ACB$name".replaceAll('.', '_');
    } else {
      var n = name.split(' ').last;
      if (n.length == 1) n = '0$n';
      return 'MM$n';
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