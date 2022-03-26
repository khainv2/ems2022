import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

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

Widget getImageStack(String path, int width, int height){
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
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
          points: [
            Point(1500, 500),
            Point(1300, 700),
            Point(1500, 900),
          ],
          imageWidth: width,
          imageHeight: height
        ), //3
      ),
    ]
  );
}

final msbImageList = [
  getImageStack("assets/images/msb12.png", 4122, 1968),
  getImageStack("assets/images/msb3.png", 4640, 2266),
  getImageStack("assets/images/msb4.png", 4443, 1727),
];
class OverviewDevice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OverviewDeviceState();
  }
}

class _OverviewDeviceState extends State<OverviewDevice> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: msbImageList,
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () => _controller.previousPage(),
              child: Text('←'),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: () => _controller.animateToPage(0),
              child: Text('MSB1 + MSB2', style: TextStyle(color: _current == 0 ? accentColor : Colors.white),),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: () => _controller.animateToPage(1),
              child: Text('MSB3', style: TextStyle(color: _current == 1 ? accentColor : Colors.white),),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: () => _controller.animateToPage(2),
              child: Text('MSB4', style: TextStyle(color: _current == 2 ? accentColor : Colors.white),),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: () => _controller.nextPage(),
              child: Text('→'),
            ),
            Expanded(child: Container()),
          ],
        )
      ]),
    );
  }
}