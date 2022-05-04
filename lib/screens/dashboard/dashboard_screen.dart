import 'package:admin/models/msb.dart';
import 'package:admin/screens/dashboard/components/overviewdevice.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class MsbOverview extends CustomPainter {
  MSBDiagram diagram;

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
    canvas.drawLine(Offset(t, vmed), Offset(w, vmed), paint);
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
    double vmed = height / 2;
    
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
        // if (vnode.devices.contains(NodeDeviceType.Switch)){
        //   // Vẽ Switch
        //   final p1 = Offset(hx, vmed - switchVPos + (switchHeight / 2));
        //   final p2 = Offset(hx, vmed - switchVPos - (switchHeight / 2));
        //   paint.color = accentColor;
        //   paint.strokeWidth = 2;
        //   paint.style = PaintingStyle.stroke;
        //   canvas.drawCircle(p1, 3, paint);
        //   canvas.drawCircle(p2, 3, paint);
        //   paint.strokeWidth = 2;
        //   canvas.drawLine(p2, p1 + Offset(-15, -5), paint);
        //   paint.style = PaintingStyle.fill;
        //   paint.color = secondaryColor;
        //   canvas.drawCircle(p1, 3, paint);
        //   canvas.drawCircle(p2, 3, paint);
        // }
      }
    }
  }

  void drawSwitch(Canvas canvas, Size size){
    final numPos = diagram.numPos.toDouble();
    double width = size.width, height = size.height;
    double vmed = height / 2;
    
    final paint = Paint();
    for (final vnode in diagram.vNodes){
      final hx = vnode.pos * width / numPos;
      if (vnode.devices.contains(NodeDeviceType.NormalLoad)){
        
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
        }
      }
    }
  }

  void drawMultimeter(Canvas canvas, Offset offset){
   
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyleWhite = TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);
    final textStyleBlack = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold);
    final textStyleAccent = TextStyle(color: accentColor, fontSize: 12);

    final r = RRect.fromLTRBR(offset.dx, offset.dy, offset.dx + 72, offset.dy + 120, Radius.circular(10));
    paint.style = PaintingStyle.stroke;
    paint.color = accentColor;
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
    textPainter.text = TextSpan(text: "MFM", style: textStyleBlack);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(6, 5));

    paint.color = secondaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(r2.bottomCenter + Offset(0, 10), 4, paint);
    canvas.drawCircle(r2.bottomCenter + Offset(-20, 10), 4, paint);
    canvas.drawCircle(r2.bottomCenter + Offset( 20, 10), 4, paint);

    final xKeyOffset = 10.0;
    final xValueOffset = 32.0;
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

    textPainter.text = TextSpan(text: "0 V", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset));

    textPainter.text = TextSpan(text: "0 A", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 1));

    textPainter.text = TextSpan(text: "0 Hz", style: textStyleWhite);
    textPainter.layout(minWidth: 0, maxWidth: 500);
    textPainter.paint(canvas, Offset(r.left, r.top) + Offset(xValueOffset, yOffset + ySpacing * 2));

    textPainter.text = TextSpan(text: "0 W", style: textStyleWhite);
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
          drawMultimeter(canvas, Offset(hx + 8, paddingTop + 30));
        }
      } else if (vnode.devices.contains(NodeDeviceType.GNode) || vnode.devices.contains(NodeDeviceType.Transformer)){
        if (vnode.devices.contains(NodeDeviceType.Multimeter)){
          drawMultimeter(canvas, Offset(hx + 8, vmed + 30));
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
  
  @override
  void paint(Canvas canvas, Size size) {

    drawHorizontalWireList(canvas, size);
    drawVerticalWireList(canvas, size);

    drawHorizontalACBList(canvas, size);
    drawVerticalACBList(canvas, size);

    drawLoader(canvas, size);
    drawMultimeterList(canvas, size);

    drawGNode(canvas, size);
    drawTransformerList(canvas, size);
    
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
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: CustomPaint(
      size: Size.infinite,
      painter: MsbOverview(diagram: msb3), //3
    ),
  ),
  Container(
    padding: EdgeInsets.all(defaultPadding),
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
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
