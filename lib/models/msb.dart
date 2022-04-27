import 'package:admin/models/device.dart';

enum NodeDeviceType {
  NormalLoad, 
  Transformer,
  GNode,
  Switch, 
  ACB,
  Multimeter
}

// Mô tả trạng thái của ACB 
enum ACBDeviceState { Off, On, Trip }

// Mô tả 1 thiết bị ACB
class ACBDevice {
  var name = "";
  var state = ACBDeviceState.Off;
}

// Mô tả 1 thiết bị Multimeter
class MultimeterDevice {
  Map<String, String> params = {};
}

// Mô tả 1 node nằm ngang trên sơ đồ điện
class HNode {
  var acbDevice = ACBDevice();
  var pos = 0;
}

// Mô tả 1 node dọc trên sơ đồ điện bao gồm nhiều thiết bị 
class VNode {
  var name = "";
  var info = "";
  var multimeter = MultimeterDevice();
  var acb = ACBDevice();
  var pos = 0;
  Set<NodeDeviceType> devices = {};
}

// Tổng quan sơ đồ điện hệ thống tủ điện 
class MSBDiagram {
  int numPos = 0;
  List<HNode> hNodes = [];
  List<VNode> vNodes = [];
}

class Msb {
  final int id;
  final String? title;
  final bool? online;
  List<Device>? deviceList = [];
  Msb({ required this.id, 
  this.title, this.online, this.deviceList });
}
