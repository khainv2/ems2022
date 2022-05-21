
import 'package:flutter/material.dart';

enum EventType {
  Info, Warning, Error, Critical
}

enum EventLevel {
  High,
  Mid, 
  Low
}

EventLevel getLevelFromValue(int value){
  if (value == 1) return EventLevel.High; 
  if (value == 2) return EventLevel.Mid;
  return EventLevel.Low;
}

String levelToString(EventLevel level){
  if (level == EventLevel.High) return 'Cao';
  else if (level == EventLevel.Mid) return 'Vừa';
  else return 'Thấp';
}

Color levelToColor(EventLevel level){
  if (level == EventLevel.High) return Colors.red;
  else if (level == EventLevel.Mid) return Colors.orange;
  else return Colors.green;
}

class Event {
  int num = 0;
  String id = '';
  EventType type;
  EventLevel level;
  String device;
  String ruleName;
  String message;
  DateTime time;
  bool readed;

  Event({
    this.id = '',
    required this.num, 
    required this.type, 
    required this.message, 
    required this.time, 
    required this.readed,
    this.device = '',
    this.ruleName = '',
    this.level = EventLevel.High
  });
}
