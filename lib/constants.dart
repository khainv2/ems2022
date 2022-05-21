import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColor = Color(0xFF2697FF);
// const secondaryColor = Color(0xFF2A2D3E);
const secondaryColor = Color.fromARGB(255, 39, 43, 63);
const accentColor = Color(0xFFff8f26);
const bgColor = Color(0xFF212332);
const diffColor = Color(0xffc2c2c2);
const alertColor = Color(0xffcc0000);

const defaultPadding = 16.0;
const defaultHalfPadding = 8.0;

const hostname = 'http://test.thanhnt.com:8080';

// import 'dart:ui' as ui;
// import 'package:image/image.dart' as image;

// Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
//   final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
//   image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List())!;
//   image.Image resizeImage = image.copyResize(baseSizeImage, height: height, width: width);
//   ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(image.encodePng(resizeImage)));
//   ui.FrameInfo frameInfo = await codec.getNextFrame();
//   return frameInfo.image;
// }

final fullDateFormatter = DateFormat('dd/MM/yyyy');

const defaultTableBorder = TableBorder(
  top: BorderSide(
    color: Colors.white12,
    width: 1,
  ),
  bottom: BorderSide(
    color: Colors.white12,
    width: 1,
  ),
  left: BorderSide(
    color: Colors.white12,
    width: 1,
  ),
  right: BorderSide(
    color: Colors.white12,
    width: 1,
  ),
  verticalInside: BorderSide(
    color: Colors.white12,
    width: 1,
  )
);

const defaultTableHeaderStyle = TextStyle(
  fontWeight: FontWeight.bold,
);

final defaultHeaderBackground = MaterialStateColor.resolveWith((states) => primaryColor.withAlpha(80));