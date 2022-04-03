import 'package:admin/models/device.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/msb.dart';
import '../../devicelist/components/devicedetail.dart';

class Point { int x, y; Point(this.x, this.y); }
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
  bool shouldRepaint(LightPlotter oldDelegate) {
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
        print(details.localPosition);
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
        print(size);
        
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
                    fit: BoxFit.fill,
                  ),
                ),
                child:  new Center(
                  child: Container()
                ) 
              ),
            
            CustomPaint(
              size: Size.infinite, //2
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

final msbImageList = [
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
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _current--;
                  if (_current < 0){
                    _current = msbImageList.length - 1;
                  }
                });
              },
              child: Text('←'),
            ),
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
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _current++;
                  if (_current >= msbImageList.length){
                    _current = 0;
                  }
                });
              },
              child: Text('→'),
            ),
            Expanded(child: Container()),
          ],
        )
      ]),
    );
  }
}