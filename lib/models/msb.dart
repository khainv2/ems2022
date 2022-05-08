import 'package:admin/models/device.dart';

// Mô tả các thành phần trong mạch 
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
  ACBDevice({this.name = "", this.state = ACBDeviceState.Off });
}

// Mô tả 1 thiết bị Multimeter
class MultimeterDevice {
  var name = "";
  Map<String, String> params = {};
  MultimeterDevice({required this.params, this.name = "" });
}

// Mô tả 1 node nằm ngang trên sơ đồ điện
class HNode {
  var acbDevice = ACBDevice();
  var pos = 0;
  HNode({required this.acbDevice, required this.pos });
}

// Mô tả 1 node dọc trên sơ đồ điện bao gồm nhiều thiết bị 
class VNode {
  var name = "";
  var info = "";
  MultimeterDevice? multimeter;
  ACBDevice? acb;
  var pos = 0;
  Set<NodeDeviceType> devices = {};
  VNode({
    required this.name,
    this.info = "",
    this.multimeter,
    this.acb,
    required this.pos,
    required this.devices
  });
}

enum MSBDiagramType {
  MSB12, MSB3, MSB4
}

// Tổng quan sơ đồ điện hệ thống tủ điện 
class MSBDiagram {
  MSBDiagramType type;
  int numPos = 0;
  List<HNode> hNodes = [];
  List<VNode> vNodes = [];
  MSBDiagram({required this.type, required this.numPos, required this.hNodes, required this.vNodes });
}

// Mô tả thông tin của một msb
class Msb {
  final int id;
  final String? title;
  final bool? online;
  List<Device>? deviceList = [];
  Msb({ required this.id, this.title, this.online, this.deviceList });
}
