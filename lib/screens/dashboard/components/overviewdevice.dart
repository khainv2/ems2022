import 'dart:typed_data';

import 'package:admin/models/device.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../devicelist/components/devicedetail.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;

import 'package:flutter/services.dart';

import 'package:flutter/services.dart';

class Point { 
  int x, y; 
  Point(this.x, this.y); 
  Offset toOffset(){ return Offset(x.toDouble(), y.toDouble()); } 
}

class Line { 
  Point p1, p2;
  double width; 
  Line(this.p1, this.p2, { this.width = 2 }); 
}



class LightPlotter extends CustomPainter {
  final Color color = Colors.yellow;
  final List<Point> points;
  final int imageWidth, imageHeight;
  LightPlotter({required this.points, required this.imageWidth, required this.imageHeight});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (final point in points){
      final offset = Offset(
        point.x * size.width / imageWidth, 
        point.y * size.height / imageHeight
      );
      canvas.drawCircle(offset, 10, paint);
    }
  }
  @override
  bool shouldRepaint(LightPlotter oldDelegate){
    return color != oldDelegate.color;
  }
}

class ImageStack extends StatefulWidget {
  final String imagePath;
  final int imageWidth, imageHeight;
  const ImageStack({ Key? key, required this.imagePath, required this.imageWidth, required this.imageHeight}) : super(key: key);

  @override
  State<ImageStack> createState() => _ImageStackState();
}

class _ImageStackState extends State<ImageStack> {
  final _key = GlobalKey();

  // This function is trggered somehow after build() called
  Size? _getSize() {
    final size = _key.currentContext!.size;
    if (size != null) {
      final width = size.width;
      final height = size.height;
      return Size(width, height);
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details){
        final size = _getSize();
        if (size == null)
          return;
        double vx = details.localPosition.dx / size.width;
        double vy = details.localPosition.dy / size.height;

        if (vx >= (85.0 / 1459) && vx <= (131.0 / 1459) && vy >= (96.0 / 490) && vy <= (135/490)){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return DeviceDetail(
                device: Device(
                  id: 1,
                  name: "Multimeter 1",
                  model: "EEM-MA 770",
                  address: "192.168.1.151",
                  online: true,
                  note: "MFM phía sau ACB Q3.1"
                ),
              );
            }),
          );
        }
        print("Detail pos ${details.localPosition.dx}, ${details.localPosition.dy}");        
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        key: _key, 
        // color: secondaryColor,
        child: Stack(
          children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
                child:  new Center(
                  child: Container()
                )
              ),
            
            CustomPaint(
              size: Size.infinite,
              painter: LightPlotter(
                points: [],
                imageWidth: widget.imageWidth,
                imageHeight: widget.imageHeight
              ), //3
            ),
          ]
        )
      )
    );
  }
}

Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
  final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List())!;
  image.Image resizeImage = image.copyResize(baseSizeImage, height: height, width: width);
  ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(image.encodePng(resizeImage)));
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}

class MsbOverview extends CustomPainter {
  final Size plotSize = Size(12000, 10000);
  List<Line> lines = [
    Line(Point(0, 5000), Point(12000, 5000), width: 4),
    Line(Point(1000, 1000), Point(1000, 5000)),
    Line(Point(2000, 1000), Point(2000, 5000)),
    Line(Point(3000, 1000), Point(3000, 5000)),
    Line(Point(4000, 1000), Point(4000, 5000)),
    
    Line(Point(5000, 5000), Point(5000, 8500)), 
    Line(Point(6000, 1000), Point(6000, 5000)),
    Line(Point(7000, 5000), Point(7000, 8500)), 
    Line(Point(8000, 5000), Point(8000, 8500)), 
    Line(Point(9000, 1000), Point(9000, 5000)),
    Line(Point(10000, 5000), Point(10000, 8500)), 
  ];

  ui.Image? iconMultimeter;
  
  MsbOverview(){
    
    getUiImage("assets/images/ic_multimeter.png", 64, 64).then((value) => iconMultimeter = value);
  }

  Point _plotToScreen(Point plot, Size size){
    return Point(plot.x * size.width ~/ plotSize.width, plot.y * size.height ~/ plotSize.height);
  }

  Point _screenToPlot(Point screen, Size size){
    return Point(screen.x * plotSize.width ~/ size.width, screen.y * plotSize.height ~/ size.height);
  }

  void _fillBackground(Canvas canvas, Size size){
    final paint = Paint()..color = bgColor;
    canvas.drawRect(Offset(0, 0) & size, paint);
  }

  void _drawLines(Canvas canvas, Size size){
    final paint = Paint()..color = accentColor ..strokeWidth = 2;
    for (final line in lines){
      final p1 = _plotToScreen(line.p1, size);
      final p2 = _plotToScreen(line.p2, size);
      paint.strokeWidth = line.width;
      canvas.drawLine(p1.toOffset(), p2.toOffset(), paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _fillBackground(canvas, size);
    _drawLines(canvas, size);


  }
  @override
  bool shouldRepaint(MsbOverview oldDelegate){
    return iconMultimeter != null;
  }
}

final msbImageList = [
  Container(
    padding: EdgeInsets.all(defaultPadding),
    child: CustomPaint(
      size: Size.infinite,
      painter: MsbOverview(), //3
    ),
  ),
  ImageStack(imagePath: "assets/images/msb12.png", imageWidth: 4122, imageHeight: 1968),
  ImageStack(imagePath: "assets/images/msb3.png", imageWidth: 4640, imageHeight: 2266),
  ImageStack(imagePath: "assets/images/msb4.png", imageWidth: 4443, imageHeight: 1727),
];
class OverviewDevice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OverviewDeviceState();
  }
}

class _OverviewDeviceState extends State<OverviewDevice> {
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