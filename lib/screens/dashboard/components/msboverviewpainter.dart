

import 'package:admin/constants.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msb.dart';
import 'package:flutter/material.dart';

class MsbOverviewPainter extends CustomPainter {
  MSBDiagram diagram;
  int mouseX = 0, mouseY = 0;
  DeviceTable deviceTable;

  static final paddingTop = 120.0;
  static final paddingBottom = 120.0;
  static final acbWidth = 45.0;
  static final acbHeight = 45.0;
  static final switchHeight = 30.0;
  static final acbVPos = 70.0;
  static final switchVPos = 70.0;
  static final loaderWidth = 20;
  static final loaderHeight = 30;
  static final gnodeSize = 30.0;
  static final transformerSize = 30.0;

  static var lastSize = Size(0, 0);
  var hoverMFMName = "";
  
  MsbOverviewPainter({ required this.diagram, this.mouseX = 0, this.mouseY = 0, required this.deviceTable});

  void drawHorizontalWireList(Canvas canvas, Size size){
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3;
    final numPos = diagram.numPos.toDouble();
    double w = size.width, h = size.height;
    double vmed = h / 2;
    // Horizontal wire
    double t = 0;
    for (final hnode in diagram.hNodes){
      final hx = hnode.pos * w / numPos;
      final hxmin = hx - (acbWidth / 2);
      final hxmax = hx + (acbWidth / 2);
      canvas.drawLine(Offset(t, vmed), Offset(hxmin, vmed), paint);
      t = hxmax;
    }
    canvas.drawLine(Offset(t, vmed), Offset(w - 5, vmed), paint);
  }

  void drawVerticalWireList(Canvas canvas, Size size){
    final paint = Paint() 
      ..color = Colors.green
      ..strokeWidth = 2;
    final numPos = diagram.numPos.toDouble();
    double w = size.width, h = size.height;
    double vmed = h / 2;
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * w / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        // Draw load: line from mid to top
        if (vnode.devices.contains(NodeDeviceType.Switch)){
          canvas.drawLine(Offset(hx, vmed), Offset(hx, paddingTop), paint);
          // canvas.drawLine(Offset(hx, vmed), Offset(hx, vmed - switchVPos + (switchHeight / 2)), paint);
          // canvas.drawLine(Offset(hx, vmed - switchVPos - (switchHeight / 2)), Offset(hx, paddingTop), paint);
        } else if (vnode.devices.contains(NodeDeviceType.ACB)){
          canvas.drawLine(Offset(hx, vmed), Offset(hx, vmed - acbVPos + (acbHeight / 2)), paint);
          canvas.drawLine(Offset(hx, vmed - acbVPos - (acbHeight / 2)), Offset(hx, paddingTop), paint);
        } else {
          canvas.drawLine(Offset(hx, vmed), Offset(hx, paddingTop), paint);
        }
      } else {
        if (vnode.devices.contains(NodeDeviceType.GNode)){
          canvas.drawLine(Offset(hx, vmed), Offset(hx, h - paddingBottom - acbVPos - (acbHeight / 2)), paint);
          canvas.drawLine(Offset(hx, h - paddingBottom - acbVPos + (acbHeight / 2)), Offset(hx, h - paddingBottom), paint);
        } else if (vnode.devices.contains(NodeDeviceType.Transformer)){
          canvas.drawLine(Offset(hx, vmed), Offset(hx, h - paddingBottom - acbVPos - (acbHeight / 2)), paint);
          canvas.drawLine(Offset(hx, h - paddingBottom - acbVPos + (acbHeight / 2)), Offset(hx, h - paddingBottom), paint);
        } else {        
          // Draw ground: line from mid to bottom
          canvas.drawLine(Offset(hx, vmed), Offset(hx, h), paint);
        }
      }
    }
  }

  void drawHorizontalACBList(Canvas canvas, Size size){
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;
    double vmed = height / 2;
    final textStyle = TextStyle(color: Colors.white60, fontSize: 11);
    
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (final hnode in diagram.hNodes){
      final hx = hnode.pos * width / numPos;
      final p1 = Offset(hx - (acbWidth / 2), vmed);
      final p2 = Offset(hx + (acbWidth / 2), vmed);
      paint.color = Colors.white;
      paint.strokeWidth = 2;
      paint.style = PaintingStyle.stroke;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);
      paint.strokeWidth = 2;
      canvas.drawLine(p2, p1, paint);

      paint.strokeWidth = 1;
      final mid = (p1 + p2) / 2;
      final mid1 = mid - Offset(3, 0);
      final mid2 = mid + Offset(3, 0);
      canvas.drawLine(mid1, mid1 - Offset(0, 24), paint);
      canvas.drawLine(mid2, mid2 - Offset(0, 24), paint);

      canvas.drawCircle(mid - Offset(0, 32), 8, paint);
      paint.style = PaintingStyle.fill;
      paint.color = Colors.green;
      canvas.drawCircle(mid - Offset(0, 32), 8, paint);

      paint.style = PaintingStyle.fill;
      paint.color = secondaryColor;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);

      textPainter.text = TextSpan(text: hnode.acbDevice.name, style: textStyle);
      textPainter.layout(minWidth: 0, maxWidth: size.width, );
      textPainter.paint(canvas, mid + Offset(-textPainter.width / 2, 10));
    }
  }

  void drawVerticalACB(Canvas canvas, Offset offset, String name, ACBDeviceState state){
    // Vẽ ACB
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white60, fontSize: 11);


    if (state == ACBDeviceState.Off){
      final p1 = offset + Offset(0, acbHeight / 2);
      final p2 = offset - Offset(0, acbHeight / 2);

      final mid = (p1 + p2) / 2;
      final mid1 = mid - Offset(0, 3);
      final mid2 = mid + Offset(0, 3);
      paint.strokeWidth = 2;
      paint.style = PaintingStyle.stroke;
      paint.color = Colors.white;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);
      paint.strokeWidth = 2;
      canvas.drawLine(p2, p1, paint);

      paint.strokeWidth = 1;
      canvas.drawLine(mid1, mid1 - Offset(24, 0), paint);
      canvas.drawLine(mid2, mid2 - Offset(24, 0), paint);

      canvas.drawCircle(mid - Offset(32, 0), 8, paint);
      paint.style = PaintingStyle.fill;
      paint.color = Colors.green;
      canvas.drawCircle(mid - Offset(32, 0), 8, paint);

      paint.style = PaintingStyle.fill;
      paint.color = secondaryColor;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);
    } else {
      final p1 = offset + Offset(-20, acbHeight / 2 - 5);
      final p2 = offset - Offset(0, acbHeight / 2);

      final mid = (p1 + p2) / 2;
      final mid1 = mid - Offset(0, 3);
      final mid2 = mid + Offset(0, 3);
      paint.strokeWidth = 2;
      paint.style = PaintingStyle.stroke;
      paint.color = Colors.white;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);
      paint.strokeWidth = 2;
      canvas.drawLine(p2, p1, paint);

      paint.strokeWidth = 1;
      canvas.drawLine(mid1, mid1 - Offset(24, 0), paint);
      canvas.drawLine(mid2, mid2 - Offset(24, 0), paint); 

      canvas.drawCircle(mid - Offset(32, 0), 8, paint);
      paint.style = PaintingStyle.fill;
      paint.color = Colors.red;
      canvas.drawCircle(mid - Offset(32, 0), 8, paint);

      paint.style = PaintingStyle.fill;
      paint.color = secondaryColor;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);
    }
    
    final p1 = offset + Offset(0, acbHeight / 2);
    final p2 = offset - Offset(0, acbHeight / 2);

    final mid = (p1 + p2) / 2;
    textPainter.text = TextSpan(text: name, style: textStyle);
    textPainter.layout(minWidth: 0, maxWidth: 500, );
    textPainter.paint(canvas, mid + Offset(10, - textPainter.height / 2));
  }

  void drawVerticalACBList(Canvas canvas, Size size){
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;
    double vmed = height / 2;

    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * width / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        if (vnode.devices.contains(NodeDeviceType.ACB)){
          // Vẽ các ACB ở phía trên
          drawVerticalACB(canvas, Offset(hx, vmed - acbVPos), vnode.acb!.name, vnode.acb!.state);
        }
      } else if (vnode.devices.contains(NodeDeviceType.GNode) || vnode.devices.contains(NodeDeviceType.Transformer)){
        if (vnode.devices.contains(NodeDeviceType.ACB)){
          // Vẽ các ACB ở phía dưới
          drawVerticalACB(canvas, Offset(hx, height - paddingBottom - acbVPos), vnode.acb!.name, vnode.acb!.state);
        }
      }
    }
  }

  void drawLoader(Canvas canvas, Size size){
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;
    
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white60, fontSize: 11);
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * width / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        // Vẽ các tải 
        final rect = Rect.fromLTRB(hx - (loaderWidth / 2), paddingTop - loaderHeight, hx + (loaderWidth / 2), paddingTop);
        final path = Path();
        path.moveTo(rect.bottomRight.dx, rect.bottomRight.dy);
        path.lineTo(rect.topCenter.dx, rect.topCenter.dy);
        path.lineTo(rect.bottomLeft.dx, rect.bottomRight.dy);
        paint.style = PaintingStyle.fill;
        paint.color = accentColor;
        canvas.drawPath(path, paint);
        // Vẽ mô tả của các tải
        final lines = vnode.name.split('\n');
        for (int i = 0; i < lines.length; i++){
          final line = lines[i];
          textPainter.text = TextSpan(text: line, style: textStyle);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, rect.topCenter - Offset(textPainter.width / 2, textPainter.height * (lines.length - i - 1)  + 20));
        }
      }
    }
  }

  void drawMultimeter(Canvas canvas, Offset offset, String name){
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyleWhite = TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.normal);
    final textStyleBlack = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold);

    final r = RRect.fromLTRBR(offset.dx, offset.dy, offset.dx + 72, offset.dy + 120, Radius.circular(10));
    paint.style = PaintingStyle.stroke;
    paint.color = name == hoverMFMName ? accentColor.withAlpha(200) : accentColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    // Vẽ 2 đường nối từ wire đến multimeter
    canvas.drawLine(Offset(offset.dx - 8, offset.dy + 40), Offset(offset.dx, offset.dy + 40), paint);
    canvas.drawLine(Offset(offset.dx - 8, offset.dy + 42), Offset(offset.dx, offset.dy + 42), paint);
    // Vẽ viền ngoài hình chữ nhật bo góc của multimeter
    canvas.drawRRect(r, paint);

    // Vẽ viền trong hình chữ nhật đen của multimeter
    final r2 = Rect.fromLTRB(r.left + 1, r.top + 20, r.right - 1, r.bottom - 20);
    paint.style = PaintingStyle.stroke;
    paint.color = secondaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(r2, paint);
    
    // Vẽ title của multimeter
    textPainter.text = TextSpan(text: name, style: textStyleBlack);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(6, 5));

    paint.color = secondaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(r2.bottomCenter + Offset(0, 10), 4, paint);
    canvas.drawCircle(r2.bottomCenter + Offset(-20, 10), 4, paint);
    canvas.drawCircle(r2.bottomCenter + Offset( 20, 10), 4, paint);

    final xKeyOffset = 4.0;
    final xValueOffset = 22.0;
    final yOffset = 30.0;
    final ySpacing = 16;


    textPainter.text = TextSpan(text: "U1", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset));

    textPainter.text = TextSpan(text: "I1", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset + ySpacing * 1));

    textPainter.text = TextSpan(text: "f", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset + ySpacing * 2));

    textPainter.text = TextSpan(text: "P", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset + ySpacing * 3));

    String fullName = name.replaceAll('MFM', 'Multimeter').replaceAll(' 0', ' ');
    String u1 = '0 V', i1 = '0 A', f = '0 Hz', p = '0 W';
    if (deviceTable.multimeterDevices.containsKey(fullName)){
      final deviceInfo = deviceTable.multimeterDevices[fullName]!;
      final params = deviceInfo.realtimeParam;
      if (params.containsKey('U1'))
        u1 = params['U1']!.getFullValue();
      if (params.containsKey('I1'))
        i1 = params['I1']!.getFullValue();
      if (params.containsKey('F'))
        f = params['F']!.getFullValue();
      if (params.containsKey('P'))
        p = params['P']!.getFullValue();
    }
    textPainter.text = TextSpan(text: u1, style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset));

    textPainter.text = TextSpan(text: i1, style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 1));

    textPainter.text = TextSpan(text: f, style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 2));

    textPainter.text = TextSpan(text: p, style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 3));
  }

  void drawMultimeterList(Canvas canvas, Size size){
        // Khởi tạo các tham số chung
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;
    double vmed = height / 2;
    
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * width / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        // Vẽ multimeter và các tham số 
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          drawMultimeter(canvas, Offset(hx + 8, paddingTop + 30), vnode.multimeter!.name);
        }
      } else if (vnode.devices.contains(NodeDeviceType.GNode) || vnode.devices.contains(NodeDeviceType.Transformer)){
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          drawMultimeter(canvas, Offset(hx + 8, vmed + 30), vnode.multimeter!.name);
        }
      }
    }
  }

  void drawGNode(Canvas canvas, Size size){
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;    
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white60, fontSize: 11);    
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * width / numPos;
      if (vnode.devices.contains(NodeDeviceType.GNode)){
        // Vẽ gnode
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 1;
        paint.color = accentColor;
        final gpos = Offset(hx, height - paddingBottom + gnodeSize / 2);
        canvas.drawCircle(gpos, gnodeSize / 2, paint);
        textPainter.text = TextSpan(text: vnode.info, style: textStyle);
        textPainter.layout(minWidth: 0, maxWidth: size.width, );
        textPainter.paint(canvas, gpos - Offset(textPainter.width / 2, textPainter.height / 2));

        final rect = Rect.fromLTRB(hx - gnodeSize / 2, height - paddingBottom - (gnodeSize / 2), 
                                  hx + gnodeSize / 2, height - paddingBottom);
        final path = Path();
        path.moveTo(rect.bottomRight.dx, rect.bottomRight.dy);
        path.lineTo(rect.topCenter.dx, rect.topCenter.dy);
        path.lineTo(rect.bottomLeft.dx, rect.bottomRight.dy);
        path.lineTo(rect.bottomRight.dx, rect.bottomRight.dy);
        paint.style = PaintingStyle.fill;
        canvas.drawPath(path, paint);

        // Vẽ mô tả của GNode và Transformer
        textPainter.text = TextSpan(text: vnode.name, style: textStyle);
        textPainter.layout(minWidth: 0, maxWidth: size.width);
        textPainter.paint(canvas, Offset(hx - (textPainter.width / 2), height - paddingBottom + textPainter.height + 55));
      }
    }
  }

  void drawTransformerList(Canvas canvas, Size size){
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;
    
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white60, fontSize: 11);
    
    for (final vnode in diagram.vNodes){
      if (vnode.devices.contains(NodeDeviceType.Transformer)){
        final hx = vnode.pos * width / numPos;
      
        // Vẽ các transformer
        final tpos1 = Offset(hx, height - paddingBottom + transformerSize / 2);
        final tpos2 = Offset(hx, height - paddingBottom + (transformerSize * 4 / 3));
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 1;
        paint.color = accentColor;
        canvas.drawCircle(tpos1, transformerSize / 2, paint);
        canvas.drawCircle(tpos2, transformerSize / 2, paint);
        canvas.drawLine(tpos1, tpos1 - Offset(0, 10), paint);
        canvas.drawLine(tpos1, tpos1 + Offset(8, 6), paint);
        canvas.drawLine(tpos1, tpos1 + Offset(-8, 6), paint);

        final tpos21 = tpos2 + Offset(0, 10);
        final tpos22 = tpos2 - Offset(8, 6);
        final tpos23 = tpos2 - Offset(-8, 6);

        canvas.drawLine(tpos21, tpos22, paint);
        canvas.drawLine(tpos21, tpos23, paint);
        canvas.drawLine(tpos23, tpos22, paint);
    
        // Vẽ mô tả của GNode và Transformer
        textPainter.text = TextSpan(text: vnode.name, style: textStyle);
        textPainter.layout(minWidth: 0, maxWidth: size.width);
        textPainter.paint(canvas, Offset(hx - (textPainter.width / 2), height - paddingBottom + textPainter.height + 55));

      }
    }
  }

  void drawType34(Canvas canvas, Size size){
    double width = size.width, height = size.height;
    double vmed = height / 2;
    if (diagram.type == MSBDiagramType.MSB3){
      final path = Path();
      path.moveTo(width - 30, vmed - 10);
      path.lineTo(width - 30, vmed + 10);
      path.lineTo(width, vmed);
      final paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = accentColor;
      canvas.drawPath(path, paint);

      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final textStyle = TextStyle(color: Colors.white60, fontSize: 13);

      textPainter.text = TextSpan(text: "MSB4", style: textStyle);
      textPainter.layout(minWidth: 0, maxWidth: size.width);
      textPainter.paint(canvas, Offset(width - textPainter.width - 2, vmed + textPainter.height + 20));
    } else if (diagram.type == MSBDiagramType.MSB4){
      final path = Path();
      path.moveTo(0, vmed - 10);
      path.lineTo(0, vmed + 10);
      path.lineTo(30, vmed);
      final paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = accentColor;
      canvas.drawPath(path, paint);

      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final textStyle = TextStyle(color: Colors.white60, fontSize: 13);

      textPainter.text = TextSpan(text: "MSB3", style: textStyle);
      textPainter.layout(minWidth: 0, maxWidth: size.width);
      textPainter.paint(canvas, Offset(2, vmed + textPainter.height + 5));
    }
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    lastSize = Size(size.width, size.height);

    drawHorizontalWireList(canvas, size);
    drawVerticalWireList(canvas, size);

    drawHorizontalACBList(canvas, size);
    drawVerticalACBList(canvas, size);

    drawLoader(canvas, size);
    drawMultimeterList(canvas, size);

    drawGNode(canvas, size);
    drawTransformerList(canvas, size);
    
    drawType34(canvas, size);
  }


  @override
  bool shouldRepaint(MsbOverviewPainter oldDelegate){
    if (lastSize.width == 0 || lastSize.height == 0){
      return false;
    }
    if (deviceTable != oldDelegate.deviceTable)
      return true;

    final numPos = diagram.numPos.toDouble();
    double width = lastSize.width, height = lastSize.height;
    double vmed = height / 2;
    
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * width / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        // Vẽ multimeter và các tham số 
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          final offset = Offset(hx + 8, paddingTop + 30);
          final r = Rect.fromLTRB(offset.dx, offset.dy, offset.dx + 72, offset.dy + 120);
          if (r.contains(Offset(mouseX.toDouble(), mouseY.toDouble()))){
            hoverMFMName = vnode.multimeter!.name;
          }
        }
      } else if (vnode.devices.contains(NodeDeviceType.GNode) || vnode.devices.contains(NodeDeviceType.Transformer)){
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          final offset = Offset(hx + 8, vmed + 30);
          final r = Rect.fromLTRB(offset.dx, offset.dy, offset.dx + 72, offset.dy + 120);
          if (r.contains(Offset(mouseX.toDouble(), mouseY.toDouble()))){
            hoverMFMName = vnode.multimeter!.name;
          }
        }
      }
    }
    return hoverMFMName != oldDelegate.hoverMFMName;
  }
}

