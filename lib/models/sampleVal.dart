import 'package:admin/models/energyinfo.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
import 'package:admin/models/msb.dart';

final multimeterParamList = [
  "U12","U23", "U31", 
  "U1", "U2", "U3", 
  "I1", "I2", "I3", 
  "In", "F", "P", 
  "Q", "S", "Pf", 
  "THD-U12", "THD-U23", "THD-U31", 
  "THD-U1", "THD-U2", "THD-U3",  
  "THD-I1", "THD-I2",  "THD-I3",
  "THD-In",
];

// final acbParamList = {
//   "I1", "I2", "I3",
//   "U1", "U2", "U3",
//   "P", "Q", "S", "Pf", "F",
//   "Temperature", "Operation count",
//   "Trip count", "Time last operation",
//   "Time max temperature", "Operation time", "Trip"
// };
final acbParamList = {
  "Status", "Temp", "OperCount",
  // "Temperature", "Operation count",
  // "Trip count", "Time last operation",
  // "Time max temperature", "Operation time", "Trip"
};

final multimeterSampleValue = {
  "U12": "23.289V",
  "U23": "29.282V",
  "U31": "1.389V",
  "U1": "2.823V",
  "U2": "4.832V",
  "U3": "9.483V",
  "I1": "1.2A",
  "I2": "3.2A",
  "I3": "4.2A",
  "In": "2A",
  "F": "50Hz",
  "Pf": "44",
  "Q": "3VAR",
  "S": "40VA",
  "P": "29W",
  "THD-U12": "70%",
  "THD-U23": "80%",
  "THD-U31": "75%",
  "THD-U1": "70%",
  "THD-U2": "80%",
  "THD-U3": "75%",
  "THD-I1": "70%",
  "THD-I2": "80%",
  "THD-I3": "75%",
  "THD-In": "40%",
};

String getMultimeterUnit(String name){
  if (multimeterSampleValue.containsKey(name)){
    var value = multimeterSampleValue[name]!;
    final ret = value.replaceAll(RegExp(r'[(\d).]'), '');
    return ret;
  }
  return "";
}

final acbSampleValue = {
  "I1": "1.2A",
  "I2": "3.2A",
  "I3": "4.2A",
  "U1": "2.823V",
  "U2": "4.832V",
  "U3": "9.483V",
  "P": "29W",
  "Q": "3VAR",
  "S": "40VA",
  "Pf": "44",
  "F": "40Hz",
  "Temperature": "°C",
  "Operation count": "12",
  "Trip count": "22",
  "Time last operation": "23s",
  "Time max temperature": "22s",
  "Operation time": "44s",
  "Trip": "ON"
};


final sampleEventList = [

  
  Event(
    num: 1,
    type: EventType.Error,
    message: "Thiết bị Multimeter 12 (192.168.1.55) mất dữ liệu",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: true
  ),
  Event(
    num: 2,
    type: EventType.Error,
    message: "Thiết bị Multimeter 13 (192.168.1.55) mất dữ liệu",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  Event(
    num: 3,
    type: EventType.Error,
    message: "Thiết bị Multimeter 14 (192.168.1.55) mất dữ liệu",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  Event(
    num: 3,
    type: EventType.Error,
    message: "Thiết bị Multimeter 15 (192.168.1.55) gặp lỗi mất dữ liệu",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  Event(
    num: 4,
    type: EventType.Critical,
    message: "Hệ thống mạng không ổn định",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  
  Event(
    num: 6,
    type: EventType.Warning,
    message: "Thiết bị ACB 01 không ổn định",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
];

final sampleLogList = [
  Log(
    num: 0,
    type: LogType.Info,
    message: "Người dùng 'user1' mới đăng nhập",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: true
  ),
  Log(
    num: 7,
    type: LogType.Info,
    message: "Người dùng 'user2' mới đăng nhập",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  Log(
    num: 8,
    type: LogType.Info,
    message: "Người dùng 'user4' mới đăng nhập",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  Log(
    num: 9,
    type: LogType.Info,
    message: "Người dùng 'user5' mới đăng nhập",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  Log(
    num: 5,
    type: LogType.Info,
    message: "Người dùng 'user3' mới đăng nhập",
    time: DateTime(2022, 03, 27, 14, 22, 25),
    readed: false
  ),
  
];

final sampleDailyEnergy = [
  // DailyEnergyInfo(0, 34),
  DailyEnergyInfo(1, 66),
  DailyEnergyInfo(2, 23),
  DailyEnergyInfo(3, 53),
  DailyEnergyInfo(4, 34),
  DailyEnergyInfo(5, 97),
  DailyEnergyInfo(6, 63),
  DailyEnergyInfo(7, 53),
  DailyEnergyInfo(8, 68),
  DailyEnergyInfo(9, 32),
  DailyEnergyInfo(10, 46),
  DailyEnergyInfo(11, 77),
  DailyEnergyInfo(12, 32),
  DailyEnergyInfo(13, 85),
  DailyEnergyInfo(14, 99),
  DailyEnergyInfo(15, 12),
  DailyEnergyInfo(16, 53),
  DailyEnergyInfo(17, 53),
  DailyEnergyInfo(18, 56),
  DailyEnergyInfo(19, 75),
  DailyEnergyInfo(20, 54),
  DailyEnergyInfo(21, 43),
  DailyEnergyInfo(22, 22),
  DailyEnergyInfo(23, 11),
  DailyEnergyInfo(24, 11),
  DailyEnergyInfo(25, 11),
  DailyEnergyInfo(26, 11),
  DailyEnergyInfo(27, 11),
  DailyEnergyInfo(28, 11),
  DailyEnergyInfo(29, 11),
  DailyEnergyInfo(30, 11),
  DailyEnergyInfo(31, 11),
];

final sampleMonthlyEnergy = [
  MonthlyEnergyInfo(1, 794),
  MonthlyEnergyInfo(2, 235),
  MonthlyEnergyInfo(3, 890),
  MonthlyEnergyInfo(4, 452),
  MonthlyEnergyInfo(5, 794),
  MonthlyEnergyInfo(6, 235),
  MonthlyEnergyInfo(7, 890),
  MonthlyEnergyInfo(8, 452),
  MonthlyEnergyInfo(9, 794),
  MonthlyEnergyInfo(10, 235),
  MonthlyEnergyInfo(12, 890),
];