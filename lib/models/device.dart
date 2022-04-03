
/// Mô tả các loại tham số mà thiết bị có 
enum DeviceParam {
  Ua, Ub, Uc, Ia, Ib, Ic, f, P, Q, 
  Pf, Harmonic, Trip,
}

enum DeviceType {
  ACB, Multimeter
}

/// Mô tả toàn bộ tham số tại một thời điểm nhất định của thiết bị 
class DeviceParamHistoryItem {
  final Map<DeviceParam, double> param;
  final int timestamp;
  DeviceParamHistoryItem({ required this.param, required this.timestamp });
}

/// Mô tả một thiết bị cùng trạng thái đi kèm
class Device {
  final int id;
  final String name;
  final String model;
  final String? address;
  final String? modbusAddress;
  final String? note;

  final bool? online;
  final Map<DeviceParam, double>? realtimeParam;
  final List<DeviceParamHistoryItem>? deviceHistoryAllParam;
  Device({
    required this.id, 
    required this.name, 
    required this.model, 
    this.address, 
    this.note,
    this.modbusAddress,
    this.online,
    this.realtimeParam,
    this.deviceHistoryAllParam
  });
}