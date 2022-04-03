
enum LogType {
  Info, Warning, Error, Critical
}
class Log {
  int num = 0;
  LogType type;
  String message;
  DateTime time;
  bool readed;

  Log({required this.num, required this.type, required this.message, required this.time, required this.readed});
}
