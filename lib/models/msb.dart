import 'package:admin/models/device.dart';

class Msb {
  final int id;
  final String? title;
  final bool? online;
  List<Device>? deviceList = [];
  Msb({ required this.id, 
  this.title, this.online, this.deviceList });
}

