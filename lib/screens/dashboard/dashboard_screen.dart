import 'package:admin/models/msb.dart';
import 'package:admin/screens/dashboard/components/device_alarm.dart';
import 'package:admin/screens/dashboard/components/device_status.dart';
import 'package:admin/screens/dashboard/components/overview_event_list.dart';
import 'package:admin/screens/dashboard/components/overviewdevice.dart';
import 'package:admin/screens/dashboard/components/statistic.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


class MsbOverview extends CustomPainter {
  MSBDiagram diagram;
  // ui.Image? iconMultimeter;

  final paddingTop = 120.0;
  final paddingBottom = 120.0;
  final acbWidth = 45.0;
  final acbHeight = 45.0;
  final switchHeight = 30.0;
  final acbVPos = 70.0;
  final switchVPos = 70.0;
  final loaderWidth = 20;
  final loaderHeight = 30;
  final gnodeSize = 30.0;
  final transformerSize = 30.0;
  
  MsbOverview({ required this.diagram }){
    // getUiImage("assets/images/ic_multimeter.png", 64, 64).then((value) => iconMultimeter = value);
  }

  List<Line> createHorizontalWireList(Size size){
    List<Line> output = [];
    final numPos = diagram.numPos.toDouble();
    double w = size.width, h = size.height;
    double vmed = h / 2;
    // Horizontal wire
    double t = 0;
    for (final hnode in diagram.hNodes){
      final hx = hnode.pos * w / numPos;
      final hxmin = hx - (acbWidth / 2);
      final hxmax = hx + (acbWidth / 2);
      final line = Line(p1: Point(t, vmed), p2: Point(hxmin, vmed));
      output.add(line);
      t = hxmax;
    }
    final lastLine = Line(p1: Point(t, vmed), p2: Point(w, vmed));
    output.add(lastLine);
    return output;
  }

  List<Line> createVerticalWireList(Size size){
    List<Line> output = [];
    final numPos = diagram.numPos.toDouble();
    double w = size.width, h = size.height;
    double vmed = h / 2;
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * w / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        // Draw load: line from mid to top
        if (vnode.devices.contains(NodeDeviceType.Switch)){
          final line1 = Line(p1: Point(hx, vmed), p2: Point(hx, vmed - switchVPos + (switchHeight / 2)));
          final line2 = Line(p1: Point(hx, vmed - switchVPos - (switchHeight / 2)), p2: Point(hx, paddingTop));
          output.add(line1); 
          output.add(line2);
        } else if (vnode.devices.contains(NodeDeviceType.ACB)){
          final line1 = Line(p1: Point(hx, vmed), p2: Point(hx, vmed - acbVPos + (acbHeight / 2)));
          final line2 = Line(p1: Point(hx, vmed - acbVPos - (acbHeight / 2)), p2: Point(hx, paddingTop));
          output.add(line1); 
          output.add(line2);
        } else {
          final line = Line(p1: Point(hx, vmed), p2: Point(hx, paddingTop));
          output.add(line);
        }
      } else {
        if (vnode.devices.contains(NodeDeviceType.GNode)){
          final line1 = Line(p1: Point(hx, vmed), p2: Point(hx, h - paddingBottom - acbVPos - (acbHeight / 2)));
          final line2 = Line(p1: Point(hx, h - paddingBottom - acbVPos + (acbHeight / 2)), p2: Point(hx, h - paddingBottom));
          output.add(line1); 
          output.add(line2);
        } else if (vnode.devices.contains(NodeDeviceType.Transformer)){
          final line1 = Line(p1: Point(hx, vmed), p2: Point(hx, h - paddingBottom - acbVPos - (acbHeight / 2)));
          final line2 = Line(p1: Point(hx, h - paddingBottom - acbVPos + (acbHeight / 2)), p2: Point(hx, h - paddingBottom));
          output.add(line1); 
          output.add(line2);
        } else {        
          // Draw ground: line from mid to bottom
          final line = Line(p1: Point(hx, vmed), p2: Point(hx, h));
          output.add(line); 
        }
      }
    }
    return output;
  }

  List<Rect> createLoaderRectList(Size size){
    List<Rect> output = [];
    final numPos = diagram.numPos.toDouble();
    double w = size.width, h = size.height;
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * w / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        final rect = Rect.fromLTRB(hx - (loaderWidth / 2), paddingTop - loaderHeight, hx + (loaderWidth / 2), paddingTop);
        output.add(rect);
      }
    }
    return output;
  }

  @override
  void paint(Canvas canvas, Size size) {

    final numPos = diagram.numPos.toDouble();
    double w = size.width, h = size.height;
    double vmed = h / 2;
    
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final textStyle = TextStyle(color: Colors.white60, fontSize: 11);
    final textStyleWhite = TextStyle(color: Colors.white, fontSize: 10);
    final textStyleAccent = TextStyle(color: accentColor, fontSize: 10);
    
    // Vẽ đường điện ngang
    paint.color = Colors.white70;
    paint.strokeWidth = 3;
    final hwirelist = createHorizontalWireList(size);
    for (final line in hwirelist){
      canvas.drawLine(line.p1.toOffset(), line.p2.toOffset(), paint);
    }

    // Vẽ các ACB
    for (final hnode in diagram.hNodes){
      final hx = hnode.pos * w / numPos;
      final p1 = Offset(hx - (acbWidth / 2), vmed);
      final p2 = Offset(hx + (acbWidth / 2), vmed);
      paint.color = accentColor;
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
      paint.color = secondaryColor;
      canvas.drawCircle(p1, 4, paint);
      canvas.drawCircle(p2, 4, paint);

      textPainter.text = TextSpan(text: hnode.acbDevice.name, style: textStyle);
      textPainter.layout(minWidth: 0, maxWidth: size.width, );
      textPainter.paint(canvas, mid + Offset(-textPainter.width / 2, 10));
    }

    // Vẽ đường điện dọc
    paint.color = Colors.white70;
    paint.strokeWidth = 2;
    final vwirelist = createVerticalWireList(size);
    for (final line in vwirelist){
      canvas.drawLine(line.p1.toOffset(), line.p2.toOffset(), paint);
    }

    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * w / numPos;
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
        if (vnode.devices.contains(NodeDeviceType.Switch)){
          // Vẽ Switch
          final p1 = Offset(hx, vmed - switchVPos + (switchHeight / 2));
          final p2 = Offset(hx, vmed - switchVPos - (switchHeight / 2));
          paint.color = accentColor;
          paint.strokeWidth = 2;
          paint.style = PaintingStyle.stroke;
          canvas.drawCircle(p1, 3, paint);
          canvas.drawCircle(p2, 3, paint);
          paint.strokeWidth = 2;
          canvas.drawLine(p2, p1 + Offset(-15, -5), paint);
          paint.style = PaintingStyle.fill;
          paint.color = secondaryColor;
          canvas.drawCircle(p1, 3, paint);
          canvas.drawCircle(p2, 3, paint);
        } else if (vnode.devices.contains(NodeDeviceType.ACB)){
          // Vẽ ACB
          final p1 = Offset(hx, vmed - acbVPos + (acbHeight / 2));
          final p2 = Offset(hx, vmed - acbVPos - (acbHeight / 2));
          paint.strokeWidth = 2;
          paint.style = PaintingStyle.stroke;
          canvas.drawCircle(p1, 4, paint);
          canvas.drawCircle(p2, 4, paint);
          paint.strokeWidth = 2;
          canvas.drawLine(p2, p1, paint);

          paint.strokeWidth = 1;
          final mid = (p1 + p2) / 2;
          final mid1 = mid - Offset(0, 3);
          final mid2 = mid + Offset(0, 3);
          canvas.drawLine(mid1, mid1 - Offset(24, 0), paint);
          canvas.drawLine(mid2, mid2 - Offset(24, 0), paint);

          canvas.drawCircle(mid - Offset(32, 0), 8, paint);

          paint.style = PaintingStyle.fill;
          paint.color = secondaryColor;
          canvas.drawCircle(p1, 4, paint);
          canvas.drawCircle(p2, 4, paint);

          textPainter.text = TextSpan(text: vnode.acb!.name, style: textStyle);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, mid + Offset(10, - textPainter.height / 2));
        }

        // Vẽ multimeter và các tham số 
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          
          final r = RRect.fromLTRBR(hx + 8, paddingTop + 40, hx + 76, paddingTop + 150, Radius.circular(10));
          paint.style = PaintingStyle.stroke;
          paint.color = accentColor;
          paint.style = PaintingStyle.fill;
          paint.strokeWidth = 1;

          canvas.drawLine(Offset(hx, paddingTop + 60), Offset(hx + 8, paddingTop + 60), paint);
          canvas.drawRRect(r, paint);
          final r2 = Rect.fromLTRB(r.left, r.top + 18, r.right, r.bottom - 18);
          paint.style = PaintingStyle.stroke;
          paint.color = secondaryColor;
          paint.style = PaintingStyle.fill;
          canvas.drawRect(r2, paint);

          textPainter.text = TextSpan(text: "Multimeter 1", style: textStyleWhite);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(6, 6));
          
          final xKeyOffset = 10.0;
          final xValueOffset = 32.0;
          final yOffset = 24.0;
          final ySpacing = 16;

          textPainter.text = TextSpan(text: "U1", style: textStyleWhite);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset));
          
          textPainter.text = TextSpan(text: "U2", style: textStyleWhite);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset + ySpacing * 1));
          
          textPainter.text = TextSpan(text: "U3", style: textStyleWhite);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset + ySpacing * 2));
          
          textPainter.text = TextSpan(text: "I1", style: textStyleWhite);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xKeyOffset, yOffset + ySpacing * 3));

          textPainter.text = TextSpan(text: "2.38V", style: textStyleAccent);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset));
          
          textPainter.text = TextSpan(text: "3.28V", style: textStyleAccent);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 1));
          
          textPainter.text = TextSpan(text: "2.22V", style: textStyleAccent);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 2));
          
          textPainter.text = TextSpan(text: "1.82A", style: textStyleAccent);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 3));
        }

      } else if (vnode.devices.contains(NodeDeviceType.GNode) || vnode.devices.contains(NodeDeviceType.Transformer)){
        if (vnode.devices.contains(NodeDeviceType.GNode)){
          // Vẽ gnode
          paint.style = PaintingStyle.stroke;
          paint.strokeWidth = 1;
          paint.color = accentColor;
          final gpos = Offset(hx, h - paddingBottom + gnodeSize / 2);
          canvas.drawCircle(gpos, gnodeSize / 2, paint);
          textPainter.text = TextSpan(text: vnode.info, style: textStyle);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, gpos - Offset(textPainter.width / 2, textPainter.height / 2));

          final rect = Rect.fromLTRB(hx - gnodeSize / 2, h - paddingBottom - (gnodeSize / 2), 
                                    hx + gnodeSize / 2, h - paddingBottom);
          final path = Path();
          path.moveTo(rect.bottomRight.dx, rect.bottomRight.dy);
          path.lineTo(rect.topCenter.dx, rect.topCenter.dy);
          path.lineTo(rect.bottomLeft.dx, rect.bottomRight.dy);
          path.lineTo(rect.bottomRight.dx, rect.bottomRight.dy);
          paint.style = PaintingStyle.fill;
          canvas.drawPath(path, paint);
        } else {
          // Vẽ các transformer
          final tpos1 = Offset(hx, h - paddingBottom + transformerSize / 2);
          final tpos2 = Offset(hx, h - paddingBottom + (transformerSize * 4 / 3));
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
        }
        if (vnode.devices.contains(NodeDeviceType.ACB)){
          // Vẽ ACB
          final p1 = Offset(hx, h - paddingBottom - acbVPos - (acbHeight / 2));
          final p2 = Offset(hx, h - paddingBottom - acbVPos + (acbHeight / 2));
          paint.strokeWidth = 2;
          paint.style = PaintingStyle.stroke;
          canvas.drawCircle(p1, 4, paint);
          canvas.drawCircle(p2, 4, paint);
          paint.strokeWidth = 2;
          canvas.drawLine(p2, p1, paint);

          paint.strokeWidth = 1;
          final mid = (p1 + p2) / 2;
          final mid1 = mid - Offset(0, 3);
          final mid2 = mid + Offset(0, 3);
          canvas.drawLine(mid1, mid1 - Offset(24, 0), paint);
          canvas.drawLine(mid2, mid2 - Offset(24, 0), paint);

          canvas.drawCircle(mid - Offset(32, 0), 8, paint);

          paint.style = PaintingStyle.fill;
          paint.color = secondaryColor;
          canvas.drawCircle(p1, 4, paint);
          canvas.drawCircle(p2, 4, paint);
          
          textPainter.text = TextSpan(text: vnode.acb!.name, style: textStyle);
          textPainter.layout(minWidth: 0, maxWidth: size.width, );
          textPainter.paint(canvas, mid + Offset(10, - textPainter.height / 2));
        }
        // Vẽ mô tả của GNode và Transformer
        textPainter.text = TextSpan(text: vnode.name, style: textStyle);
        textPainter.layout(minWidth: 0, maxWidth: size.width);
        textPainter.paint(canvas, Offset(hx - (textPainter.width / 2), h - paddingBottom + textPainter.height + 55));

      }
    }
  }
  @override
  bool shouldRepaint(MsbOverview oldDelegate){
    // return iconMultimeter != null;
    return false;
  }
}

final msbImageList = [
  Container(
    padding: EdgeInsets.all(defaultPadding),
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: CustomPaint(
      size: Size.infinite,
      painter: MsbOverview(diagram: msb12Diagram), //3
    ),
  ),
  Container(
    padding: EdgeInsets.all(defaultPadding),
    child: CustomPaint(
      size: Size.infinite,
      painter: MsbOverview(diagram: msb3), //3
    ),
  ),
  Container(
    padding: EdgeInsets.all(defaultPadding),
    child: CustomPaint(
      size: Size.infinite,
      painter: MsbOverview(diagram: msb4), //3
    ),
  ),
  ImageStack(imagePath: "assets/images/msb12.png", imageWidth: 4122, imageHeight: 1968),
  ImageStack(imagePath: "assets/images/msb3.png", imageWidth: 4640, imageHeight: 2266),
  ImageStack(imagePath: "assets/images/msb4.png", imageWidth: 4443, imageHeight: 1727),
];

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: IndexedStack(
            children: msbImageList,
            index: _current,
          )
        ),
        SizedBox(height: defaultHalfPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Container()),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _current = 0;
                });
              },
              child: Text('MSB1 + MSB2', style: TextStyle(color: _current == 0 ? accentColor : Colors.white),),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _current = 1;
                });
              },
              child: Text('MSB3', style: TextStyle(color: _current == 1 ? accentColor : Colors.white),),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _current = 2;
                });
              },
              child: Text('MSB4', style: TextStyle(color: _current == 2 ? accentColor : Colors.white),),
            ),
            SizedBox(width: defaultPadding),
            Expanded(child: Container()),
          ],
        )
      ]),
    );
  }
}
