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
  ACBDevice({this.name = "", this.state = ACBDeviceState.Off });
}

// Mô tả 1 thiết bị Multimeter
class MultimeterDevice {
  Map<String, String> params = {};
  MultimeterDevice({required this.params});
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

// Tổng quan sơ đồ điện hệ thống tủ điện 
class MSBDiagram {
  int numPos = 0;
  List<HNode> hNodes = [];
  List<VNode> vNodes = [];
  MSBDiagram({required this.numPos, required this.hNodes, required this.vNodes });
}

final testParams = {
  "Ua" : "234V",
  "Ub" : "123V",
  "Uc" : "22V",
};

final msb12Diagram = MSBDiagram(
  numPos: 15,
  hNodes: [
    HNode(
      acbDevice: ACBDevice( name: "Q1.6" ),
      pos: 6,
    ),
    HNode(
      acbDevice: ACBDevice( name: "Q1.3" ),
      pos: 10,
    ),
    HNode(
      acbDevice: ACBDevice( name: "Q2.5" ),
      pos: 14,
    )
  ],
  vNodes: [
    VNode(
      name: "TĐ-CHILLER4\n183KW", pos: 2, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams )
    ),
    VNode(
      name: "P.MÁY IN TẦNG 2\nTĐ-ĐL4\n200KW", pos: 3, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams )
    ),
    VNode(
      name: "P.RỬA, DUNG MÔI\nTĐ-DM\n50KW", pos: 4, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams )
    ),
    VNode(
      name: "KHO PALLET\nTĐ-PAL\n75KW", pos: 5, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams )
    ),
    VNode(
      name: "FROM LVG1*.2 PANEL", pos: 7, info: "G1",
      devices: { NodeDeviceType.GNode, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams )
    ),
    VNode(
      name: "PHÒNG MÁY IN PHỦ\nTĐ-ĐL1\n2190KW", pos: 8, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.ACB },
      acb: ACBDevice( name: "Q1.4" )
    ),
    VNode(
      name: "FROM MV PANEL", pos: 9, 
      devices: { NodeDeviceType.Transformer, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams ),
      acb: ACBDevice( name: "Q1.1" )
    ),
    VNode(
      name: "FROM MV PANEL", pos: 11, 
      devices: { NodeDeviceType.Transformer, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams ),
      acb: ACBDevice( name: "Q2.1" )
    ),
    VNode(
      name: "PHÒNG MÁY IN PHỦ\nTĐ-ĐL2\n3270KW", pos: 12, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.ACB },
      acb: ACBDevice( name: "Q2.3" )
    ),
    VNode(
      name: "FROM LVG1*.2 PANEL", pos: 13, info: "G2",
      devices: { NodeDeviceType.GNode, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams )
    ),
  ]
);

class Msb {
  final int id;
  final String? title;
  final bool? online;
  List<Device>? deviceList = [];
  Msb({ required this.id, 
  this.title, this.online, this.deviceList });
}
