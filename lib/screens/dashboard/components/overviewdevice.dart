import 'dart:typed_data';

import 'package:admin/models/device.dart';
import 'package:admin/models/msb.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../devicelist/devicedetail.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;

import 'package:flutter/services.dart';

class Point { 
  double x = 0, y = 0; 
  Point(this.x, this.y); 
  Offset toOffset(){ return Offset(x, y); } 
}

class Line { 
  Point p1, p2;
  Line({required this.p1, required this.p2});
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
