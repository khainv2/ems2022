import 'msb.dart';

final testParams = {
  "Ua" : "234V",
  "Ub" : "123V",
  "Uc" : "22V",
};

final msb12 = MSBDiagram(
  type: MSBDiagramType.MSB12,
  numPos: 150,
  hNodes: [
    HNode(
      acbDevice: ACBDevice( name: "Q1.3" ),
      pos: 102,
    ),
  ],
  vNodes: [
    VNode(
      name: "TĐ-CHILLER4\n183KW", pos: 10, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 05" )
    ),
    VNode(
      name: "P.MÁY IN TẦNG 2\nTĐ-ĐL4\n200KW", pos: 25, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 06" )
    ),
    VNode(
      name: "P.RỬA, DUNG MÔI\nTĐ-DM\n75KW", pos: 40, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 04" )
    ),
    VNode(
      name: "KHO PALLET\nTĐ-PAL\n75KW", pos: 55, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 03" )
    ),
    VNode(
      name: "FROM LVG1*.2 PANEL", pos: 67, info: "G1",
      devices: { NodeDeviceType.GNode, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 02" ),
      acb: ACBDevice( name: "Q1.2" )
    ),
    VNode(
      name: "PHÒNG MÁY IN PHỦ\nTĐ-ĐL1\n2190KW", pos: 79, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.ACB, NodeDeviceType.Multimeter  },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 31" ),
      acb: ACBDevice( name: "Q1.4", state: ACBDeviceState.On )
    ),
    VNode(
      name: "FROM MV PANEL", pos: 88, 
      devices: { NodeDeviceType.Transformer, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 01" ),
      acb: ACBDevice( name: "Q1.1" )
    ),
    VNode(
      name: "FROM MV PANEL", pos: 110, 
      devices: { NodeDeviceType.Transformer, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 07" ),
      acb: ACBDevice( name: "Q2.1" , state: ACBDeviceState.On )
    ),
    VNode(
      name: "PHÒNG MÁY IN PHỦ\nTĐ-ĐL2\n3270KW", pos: 120, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 32" ),
      acb: ACBDevice( name: "Q2.3" )
    ),
    VNode(
      name: "FROM LVG1*.2 PANEL", pos: 130, info: "G2",
      devices: { NodeDeviceType.GNode, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 08" ),
      acb: ACBDevice( name: "Q2.2" )
    ),
  ]
);

final msb3 = MSBDiagram(
  type: MSBDiagramType.MSB3,
  numPos: 190, 
  hNodes: [
    HNode(pos: 110, acbDevice: ACBDevice(name: "Q3.5")),
    HNode(pos: 180, acbDevice: ACBDevice(name: "Q3.3")),
  ],
  vNodes: [
    VNode(
      name: "TĐ-CHILLER1\n120KW", pos: 5, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 23" )
    ),
    VNode(
      name: "TĐ-CHILLER3\n183KW", pos: 17, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 22" )
    ),
    VNode(
      name: "P.CƠ KHÍ\nTĐ-CK\n183KW", pos: 29, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 21" )
    ),
    VNode(
      name: "TĐ-CHILLER2\n183KW", pos: 41, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 20" )
    ),
    VNode(
      name: "TĐ-AHU1~3\n20.5KW", pos: 53, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 19" )
    ),
    VNode(
      name: "TĐ-TG-T1\n26.3KW", pos: 65, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 18" )
    ),
    VNode(
      name: "TĐ-TG-T2\n43.6KW", pos: 77, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 17" )
    ),
    VNode(
      name: "TĐ-BƠM-AHU\n60KW", pos: 89, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 16" )
    ),
    VNode(
      name: "NHÀ VP\nTĐT-VP\n204.5KW", pos: 100, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 15" )
    ),

    VNode(
      name: "PHÒNG MÁY THÔI MÀNG\nTĐ-ĐL3\n670KW", pos: 120, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 14" ),
      // acb: ACBDevice( name: "Q3.4" )
    ),
    VNode(
      name: "FROM LVG1*.2 PANEL", pos: 130, info: "G3",
      devices: { NodeDeviceType.GNode, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 10" ),
      acb: ACBDevice( name: "Q3.2" )
    ),
    VNode(
      name: "XƯỞNG\nTĐ-1\n74.4KW", pos: 142, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 13" ),
    ),
    VNode(
      name: "TĐ-2\n63.3KW", pos: 155, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 12" ),
    ),
    VNode(
      name: "FROM MV PANEL", pos: 160, 
      devices: { NodeDeviceType.Transformer, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 09" ),
      acb: ACBDevice( name: "Q3.1" )
    ),
    VNode(
      name: "MÁY NÉN\n148KW", pos: 170, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 11" ),
    ),
  ]
);

final msb4 = MSBDiagram(
  type: MSBDiagramType.MSB4,
  numPos: 130,
  hNodes: [
    HNode(acbDevice: ACBDevice(name: "Q4.3"), pos: 42),
    HNode(acbDevice: ACBDevice(name: "Q4.4"), pos: 60),
  ],
  vNodes: [
    VNode(
      name: "FROM MV PANEL", pos: 15, 
      devices: { NodeDeviceType.Transformer, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 24"),
      acb: ACBDevice( name: "Q4.1" )
    ),
    VNode(
      name: "FROM LVG1*.1 PANEL", pos: 30, info: "G4",
      devices: { NodeDeviceType.GNode, NodeDeviceType.ACB, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 25"),
      acb: ACBDevice(name: "Q4.2")
    ),
    VNode(
      name: "TĐ-XMỰC\n170KW", pos: 50, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 26")
    ),
    VNode(
      name: "PHÒNG M.CẮT VÀ Đ.GÓI\nTĐ-ĐG\n236KW", pos: 70, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 27")
    ),
    VNode(
      name: "PHÒNG MÁY IN PHỦ\nTĐ-DCT\n1197KW", pos: 85, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 28"),
      // acb: ACBDevice(name: "Q4.6")
    ),
    VNode(
      name: "TĐ-AHU-4~7\n30KW", pos: 100, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 29" )
    ),
    VNode(
      name: "NHÀ VP\nHVAC-VP\n180.9KW", pos: 115, 
      devices: { NodeDeviceType.NormalLoad, NodeDeviceType.Switch, NodeDeviceType.Multimeter },
      multimeter: MultimeterDevice( params: testParams, name: "MFM 30" )
    ),
  ]
);