import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
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
