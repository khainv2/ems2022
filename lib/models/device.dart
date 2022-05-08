
// Mô tả các loại tham số khác nhau của device 
class DeviceParam {
  String name;
  String value;
  String unit;
  DeviceParam(this.name, this.value, this.unit);
  String getFullValue(){ return "$value $unit"; }
}

// Mô tả 2 loại device khác nhau
enum DeviceType {
  ACB, Multimeter
}

const Map<DeviceParam, double> defaultRealtimeParam = {};
  
  /// Mô tả một thiết bị cùng trạng thái đi kèm
class Device {
  final int id;
  final String name;
  final String model;
  String address;
  String modbusAddress;
  String note;
  bool online;
  Map<DeviceParam, double> realtimeParam;
  
  Device({
    required this.id, 
    required this.name, 
    required this.model, 
    this.address = "", 
    this.note = "",
    this.modbusAddress = "",
    this.online = false,
    this.realtimeParam = defaultRealtimeParam,
  });

  String serial(){
    if (name == "ACB"){
      return "$name$model".replaceAll(".", "_");
    } else {
      String id = name.split(' ').last;
      if (id.length == 1){
        id = "0$id";
      }
      return "MM$id";
    }
  }
}