


import 'package:admin/models/energyinfo.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
import 'package:admin/models/msb.dart';

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
  "P": "29W",
  "Q": "3VAR",
  "S": "40VA",
  "Pf": "44",
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


final listMsbSample = [
  Msb(
    id: 1,
    title: "MSB1",
    online: true,
    deviceList: [
      Device(
        id: 1,
        name: "ACB",
        model: "Q1.1",
        modbusAddress: "01",
        online: false,
        note: "Nguồn cấp từ MBA 01"
      ),
      Device(
        id: 2,
        name: "ACB",
        model: "Q1.2",
        modbusAddress: "02",
        online: true,
        note: "Nguồn cấp từ lộ G1 tủ Máy phát"
      ),
      Device(
        id: 3,
        name: "ACB",
        model: "Q1.3",
        modbusAddress: "03",
        online: true,
        note: "ACB liên lạc giữa tủ MSB1 với MSB2"
      ),
      Device(
        id: 4,
        name: "ACB",
        model: "Q1.4",
        modbusAddress: "04",
        online: true,
        note: "Cấp nguồn cho tủ điện TĐ-ĐL1 (Phòng máy in phủ)"
      ),
      Device(
        id: 5,
        name: "Multimeter 1",
        model: "EEM-MA 770",
        address: "192.168.1.51",
        online: true,
        note: "Nguồn cấp từ MBA 01"
      ),
      Device(
        id: 6,
        name: "Multimeter 2",
        model: "EEM-MA 770",
        address: "192.168.1.52",
        online: true,
        note: "Nguồn cấp từ lộ G1 tủ máy phát"
      ),
      Device(
        id: 7,
        name: "Multimeter 3",
        model: "EEM-MA 770",
        address: "192.168.1.52",
        online: true,
        note: "Cáp nguồn cho tủ điện TĐ-PAL (Kho Pallet)"
      ),
      Device(
        id: 8,
        name: "Multimeter 4",
        model: "EEM-MA 770",
        address: "192.168.1.53",
        online: true,
        note: "Cấp nguồn cho tủ điện TĐ-DM (Phòng rửa dung môi)"
      ),
    ]
  ),
  Msb(
    id: 2,
    title: "MSB2",
    online: true,
    deviceList: [
      Device(
        id: 1,
        name: "ACB",
        model: "Q2.1",
        modbusAddress: "01",
        online: true,
        note: "Đầu vào từ MBA 02"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q2.2",
        modbusAddress: "02",
        online: true,
        note: "Đầu vào từ lộ G2 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q2.3",
        modbusAddress: "03",
        online: true,
        note: "Cấp nguồn cho tủ TĐ-ĐL2"
      ),
      Device(
        id: 1,
        name: "Multimeter 1",
        model: "EEM-MA 770",
        address: "192.168.1.101",
        online: true,
        note: "MFM phía sau ACB Q2.1"
      ),
      Device(
        id: 1,
        name: "Multimeter 2",
        model: "EEM-MA 770",
        address: "192.168.1.102",
        online: true,
        note: "MFM phía sau ACB Q2.2"
      ),
    ]
  ),
  Msb(
    id: 3,
    title: "MSB3",
    online: false,
    deviceList: [
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.1",
        modbusAddress: "01",
        online: true,
        note: "Đầu vào từ MBA 03"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.2",
        modbusAddress: "02",
        online: true,
        note: "Đầu vào từ lộ G3 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.3",
        modbusAddress: "03",
        online: true,
        note: "ACB liên lạc MSB3 vs MSB4"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.5",
        modbusAddress: "04",
        online: true,
        note: "ACB nhánh của tủ MSB3"
      ),
      Device(
        id: 1,
        name: "Multimeter 1",
        model: "EEM-MA 770",
        address: "192.168.1.151",
        online: true,
        note: "MFM phía sau ACB Q3.1"
      ),
      Device(
        id: 1,
        name: "Multimeter",
        model: "EEM-MA 770",
        address: "192.168.1.152",
        online: true,
        note: "MFM phía sau ACB Q3.2"
      ),
      Device(
        id: 1,
        name: "Multimeter 2",
        model: "EEM-MA 770",
        address: "192.168.1.153",
        online: true,
        note: "MFM đo lường cho tủ MÁY NÉN"
      ),
      Device(
        id: 1,
        name: "Multimeter 3",
        model: "EEM-MA 770",
        address: "192.168.1.154",
        online: true,
        note: "MFM đo lường cho tủ TĐ-2"
      ),
      Device(
        id: 1,
        name: "Multimeter 4",
        model: "EEM-MA 770",
        address: "192.168.1.155",
        online: true,
        note: "MFM đo lường cho tủ TĐ-1"
      ),
      Device(
        id: 1,
        name: "Multimeter 5",
        model: "EEM-MA 770",
        address: "192.168.1.156",
        online: true,
        note: "MFM đo lường cho tủ TĐ-ĐL3"
      ),
      Device(
        id: 1,
        name: "Multimeter 6",
        model: "EEM-MA 770",
        address: "192.168.1.157",
        online: true,
        note: "MFM đo lường cho tủ TĐT-VP"
      ),
      Device(
        id: 1,
        name: "Multimeter 7",
        model: "EEM-MA 770",
        address: "192.168.1.158",
        online: true,
        note: "MFM đo lường cho tủ TĐ-BƠM-AHU"
      ),
      Device(
        id: 1,
        name: "Multimeter 8",
        model: "EEM-MA 770",
        address: "192.168.1.159",
        online: true,
        note: "MFM đo lường cho tủ TĐ-TG-T2"
      ),
      Device(
        id: 1,
        name: "Multimeter",
        model: "EEM-MA 770",
        address: "192.168.1.160",
        online: true,
        note: "MFM đo lường cho tủ TĐ-TG-T1"
      ),
      Device(
        id: 1,
        name: "Multimeter 9",
        model: "EEM-MA 770",
        address: "192.168.1.161",
        online: true,
        note: "MFM đo lường cho tủ TĐ-AHU 1~3"
      ),
      Device(
        id: 1,
        name: "Multimeter 10",
        model: "EEM-MA 770",
        address: "192.168.1.162",
        online: true,
        note: "MFM đo lường cho tủ TĐ-CHILLER 1"
      ),
      Device(
        id: 1,
        name: "Multimeter 11",
        model: "EEM-MA 770",
        address: "192.168.1.163",
        online: true,
        note: "MFM đo lường cho tủ TĐ-CHILLER 2"
      ),
      Device(
        id: 1,
        name: "Multimeter 12",
        model: "EEM-MA 770",
        address: "192.168.1.164",
        online: true,
        note: "MFM đo lường cho tủ TĐ-CHILLER 3"
      ),
      Device(
        id: 1,
        name: "Multimeter 13",
        model: "EEM-MA 770",
        address: "192.168.1.165",
        online: true,
        note: "MFM đo lường cho tủ TĐ-CK"
      ),
    ]
  ),
  Msb(
    id: 4,
    title: "MSB4",
    online: false,
    deviceList: [
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.1",
        modbusAddress: "01",
        online: true,
        note: "Đầu vào từ MBA 04"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.2",
        modbusAddress: "02",
        online: true,
        note: "Đầu vào từ lộ G4 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.3",
        modbusAddress: "03",
        online: true,
        note: "ACB nhánh 1 của tủ MSB4"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.4",
        modbusAddress: "04",
        online: true,
        note: "ACB nhánh 2 của tủ MSB4"
      ),
      Device(
        id: 1,
        name: "Multimeter 1",
        model: "EEM-MA 770",
        address: "192.168.1.201",
        online: true,
        note: "MFM phía sau ACB Q4.1"
      ),
      Device(
        id: 1,
        name: "Multimeter 2",
        model: "EEM-MA 770",
        address: "192.168.1.202",
        online: true,
        note: "MFM phía sau ACB Q4.2"
      ),
      Device(
        id: 1,
        name: "Multimeter 3",
        model: "EEM-MA 770",
        address: "192.168.1.203",
        online: true,
        note: "MFM đo lường cho tủ TĐ-X.MỰC 1"
      ),
      Device(
        id: 1,
        name: "Multimeter 4",
        model: "EEM-MA 770",
        address: "192.168.1.204",
        online: true,
        note: "MFM đo lường cho tủ TĐ-ĐG"
      ),
      Device(
        id: 1,
        name: "Multimeter 5",
        model: "EEM-MA 770",
        address: "192.168.1.205",
        online: true,
        note: "MFM đo lường cho tủ TĐ-DCT"
      ),
      Device(
        id: 1,
        name: "Multimeter 6",
        model: "EEM-MA 770",
        address: "192.168.1.206",
        online: true,
        note: "MFM đo lường cho tủ TĐ-CHILLER 4"
      ),
      Device(
        id: 1,
        name: "Multimeter 7",
        model: "EEM-MA 770",
        address: "192.168.1.207",
        online: true,
        note: "MFM đo lường cho tủ TĐ-AHU 4~7"
      ),
      Device(
        id: 1,
        name: "Multimeter 8",
        model: "EEM-MA 770",
        address: "192.168.1.208",
        online: true,
        note: "MFM đo lường cho tủ HVAC-VP"
      ),
      Device(
        id: 1,
        name: "Multimeter 9",
        model: "EEM-MA 770",
        address: "192.168.1.209",
        online: true,
        note: "MFM đo lường cho tủ TĐ-ĐL4"
      ),
    ]
  ),
];

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
  DailyEnergyInfo(0, 34),
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
];

final sampleMonthlyEnergy = [
  MonthlyEnergyInfo(0, 452),
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
  MonthlyEnergyInfo(13, 224),
  MonthlyEnergyInfo(14, 765),
  MonthlyEnergyInfo(15, 125),
  MonthlyEnergyInfo(16, 646),
];