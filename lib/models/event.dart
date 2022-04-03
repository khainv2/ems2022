
enum EventType {
  Info, Warning, Error, Critical
}
class Event {
  int num = 0;
  EventType type;
  String message;
  DateTime time;
  bool readed;

  Event({required this.num, required this.type, required this.message, required this.time, required this.readed});
}
