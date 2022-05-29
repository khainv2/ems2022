import 'dart:async';

import 'package:admin/api/realtime.dart';
import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msb.dart';
import 'package:admin/models/msbdiagramsample.dart';
import 'package:admin/models/msblistsample.dart';
import 'package:admin/screens/dashboard/components/msboverviewpainter.dart';
import 'package:admin/screens/devicelist/devicedetail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _current = 0;
  int _x = 0, _y = 0;
  final _listMSB = [
    msb12,
    msb3,
    msb4
  ];
  var deviceTable = DeviceTable({}, {});

  Timer? timerQueryData;

  void getDataFromServer(){
    final userControl = UserControl();
    if (userControl.currentStackIndex == 0){
      getRealtimeAllDevice().then((value){
        setState(() {
          deviceTable = value;
        });
      });
    }
    
  }
  @override
  void initState(){
    super.initState();
    const oneSec = Duration(seconds: 3);
    timerQueryData = Timer.periodic(oneSec, (Timer t) => getDataFromServer());   
  }

  @override
  void dispose(){
    super.dispose();
    if (timerQueryData != null){
      timerQueryData!.cancel();
    }
  }

  void _showMSBDetail(String name){
    // Find msb name
    int index = int.parse(name.split(' ').last);
    final device = indexToDevice(index);
    
    if (device != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return DeviceDetail(
            device: Device(
              type: device.type,
              name: device.name,
              address: device.address,
              state: DeviceState.Offline,
              note: device.note
            ),
          );
        }),
      );
    }
  }
  
  void _onTabDown(TapDownDetails details){
    // print(details.localPosition);
    final mouseX = details.localPosition.dx;
    final mouseY = details.localPosition.dy;
     
    final msb =_listMSB[_current];
    final size = MsbOverviewPainter.lastSize;
    final vmed = size.height / 2;
    for (final vnode in msb.vNodes){
      final hx = vnode.pos * size.width / msb.numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        // Vẽ multimeter và các tham số 
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          final offset = Offset(hx + 8, MsbOverviewPainter.paddingTop + 30);
          final r = Rect.fromLTRB(offset.dx, offset.dy, offset.dx + 72, offset.dy + 120);
          if (r.contains(Offset(mouseX.toDouble(), mouseY.toDouble()))){
            print('Click mfm in ${vnode.multimeter!.name}');
            _showMSBDetail(vnode.multimeter!.name);
          }
        }
      } else if (vnode.devices.contains(NodeDeviceType.GNode) || vnode.devices.contains(NodeDeviceType.Transformer)){
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          final offset = Offset(hx + 8, vmed + 30);
          final r = Rect.fromLTRB(offset.dx, offset.dy, offset.dx + 72, offset.dy + 120);
          if (r.contains(Offset(mouseX.toDouble(), mouseY.toDouble()))){
            print('Click mfm in ${vnode.multimeter!.name}');
            _showMSBDetail(vnode.multimeter!.name);
          }
        }
      }
    }
  }

  void _onHover(PointerHoverEvent details){
    setState(() {
      _x = details.localPosition.dx.toInt();
      _y = details.localPosition.dy.toInt();
    });
  }

  Widget createScrollArea(Widget widget){
    final screenSize = MediaQuery.of(context).size;
    if (screenSize.width < 1300 || screenSize.height < 750){
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white24),
        ),
        child: InteractiveViewer(
          constrained: false,
          scaleEnabled: false,
          // panEnabled: false,
          child: Container(
            width: 1400,
            height: 750,
            child: widget
          )
        )
      ); 
    } else {
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white24),
        ),
        child: widget,
      );
    }
  }

  Widget createMsbOverviewPage(MSBDiagram diagram){
    return createScrollArea(
      GestureDetector(
        onTapDown: _onTabDown,
        child: MouseRegion(
          onHover: _onHover,
          child: CustomPaint(
            size: Size.infinite,
            painter: MsbOverviewPainter(
              diagram: diagram, 
              mouseX: _x, 
              mouseY: _y,
              deviceTable: deviceTable
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: IndexedStack(
            children: [
              createMsbOverviewPage(msb12),
              createMsbOverviewPage(msb3),
              createMsbOverviewPage(msb4),
            ],
            index: _current,
          )
        ),
        SizedBox(height: defaultHalfPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Container()),
            SizedBox(width: defaultPadding),
            Container(
              width: 140,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _current = 0;
                  });
                },
                child: Text('MSB1 + MSB2', style: TextStyle(color: _current == 0 ? accentColor : Colors.white),),
              ),
            ),
            
            SizedBox(width: defaultPadding),
            Container(
              width: 140,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _current = 1;
                  });
                },
                child: Text('MSB3', style: TextStyle(color: _current == 1 ? accentColor : Colors.white),),
              ),
            ),
            
            SizedBox(width: defaultPadding),
            Container(
              width: 140, 
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _current = 2;
                  });
                },
                child: Text('MSB4', style: TextStyle(color: _current == 2 ? accentColor : Colors.white),),
              ),
            ),
            
            SizedBox(width: defaultPadding),
            Expanded(child: Container()),
          ],
        )
      ]),
    );
  }
}
