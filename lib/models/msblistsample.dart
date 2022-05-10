import 'device.dart';
import 'msb.dart';

var listMsbSample = [
  Msb(
    id: 1,
    title: "MSB1",
    online: true,
    deviceList: [
      Device(
        type: DeviceType.ACB,
        name: "Q1.1",
        address: "01",
        state: DeviceState.Offline,
        note: "Nguồn cấp từ MBA 01"
      ),
      Device(
        name: "Multimeter 1",
        type: DeviceType.Multimeter,
        address: "192.168.1.51",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ MBA 01"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q1.2",
        address: "02",
        state: DeviceState.Offline,
        note: "Nguồn cấp từ lộ G1 tủ Máy phát"
      ),
      Device(
        name: "Multimeter 2",
        type: DeviceType.Multimeter,
        address: "192.168.1.52",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ lộ G1 tủ Máy phát "
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q1.3",
        address: "03",
        state: DeviceState.Offline,
        note: "ACB liên lạc giữa tủ MSB1 với MSB2"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q1.4",
        address: "04",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL1 (Phòng máy in phủ)"
      ),
      Device(
        name: "Multimeter 3",
        type: DeviceType.Multimeter,
        address: "192.168.1.53",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-PAL (Kho Pallet)"
      ),
      Device(
        name: "Multimeter 4",
        type: DeviceType.Multimeter,
        address: "192.168.1.54",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-DM (Phòng Rửa-Dung môi)"
      ),
      Device(
        name: "Multimeter 5",
        type: DeviceType.Multimeter,
        address: "192.168.1.55",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 4"
      ),
      Device(
        name: "Multimeter 6",
        type: DeviceType.Multimeter,
        address: "192.168.1.56",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL4 (Phòng máy in Tầng 2)"
      ),
    ]
  ),
  Msb(
    id: 2,
    title: "MSB2",
    online: true,
    deviceList: [
      Device(
        type: DeviceType.ACB,
        name: "Q2.1",
        address: "01",
        state: DeviceState.Offline,
        note: "Nguồn cấp từ MBA 02"
      ),
      Device(
        name: "Multimeter 7",
        type: DeviceType.Multimeter,
        address: "192.168.1.101",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ MBA 02"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q2.2",
        address: "02",
        state: DeviceState.Offline,
        note: "Đầu vào từ lộ G2 tủ Máy phát "
      ),
      Device(
        name: "Multimeter 8",
        type: DeviceType.Multimeter,
        address: "192.168.1.102",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ lộ G2 tủ Máy phát "
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q2.3",
        address: "03",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL2 (Phòng máy in phủ)"
      ),
    ]
  ),
  Msb(
    id: 3,
    title: "MSB3",
    online: true,
    deviceList: [
      Device(
        type: DeviceType.ACB,
        name: "Q3.1",
        address: "01",
        state: DeviceState.Offline,
        note: "Nguồn cấp từ MBA 03"
      ),
      Device(
        name: "Multimeter 9",
        type: DeviceType.Multimeter,
        address: "192.168.1.151",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ MBA 03"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q3.2",
        address: "02",
        state: DeviceState.Offline,
        note: "Đầu vào từ lộ G3 tủ Máy phát "
      ),
      Device(
        name: "Multimeter 10",
        type: DeviceType.Multimeter,
        address: "192.168.1.152",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ lộ G3 tủ Máy phát"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q3.3",
        address: "03",
        state: DeviceState.Offline,
        note: "ACB liên lạc MSB3 vs MSB4"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q3.5",
        address: "04",
        state: DeviceState.Offline,
        note: "ACB nhánh của tủ MSB3"
      ),
      Device(
        name: "Multimeter 11",
        type: DeviceType.Multimeter,
        address: "192.168.1.153",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện MÁY NÉN"
      ),
      Device(
        name: "Multimeter 12",
        type: DeviceType.Multimeter,
        address: "192.168.1.154",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-2"
      ),
      Device(
        name: "Multimeter 13",
        type: DeviceType.Multimeter,
        address: "192.168.1.155",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-1"
      ),
      Device(
        name: "Multimeter 14",
        type: DeviceType.Multimeter,
        address: "192.168.1.156",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL3 (Phòng máy Thổi màng)"
      ),
      Device(
        name: "Multimeter 15",
        type: DeviceType.Multimeter,
        address: "192.168.1.157",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐT-VP (Nhà văn phòng)"
      ),
      Device(
        name: "Multimeter 16",
        type: DeviceType.Multimeter,
        address: "192.168.1.158",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-BƠM-AHU"
      ),
      Device(
        name: "Multimeter 17",
        type: DeviceType.Multimeter,
        address: "192.168.1.159",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-TG-T2"
      ),
      Device(
        name: "Multimeter 18",
        type: DeviceType.Multimeter,
        address: "192.168.1.160",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-TG-T1"
      ),
      Device(
        name: "Multimeter 19",
        type: DeviceType.Multimeter,
        address: "192.168.1.161",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-AHU 1~3"
      ),
      Device(
        name: "Multimeter 20",
        type: DeviceType.Multimeter,
        address: "192.168.1.162",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 1"
      ),
      Device(
        name: "Multimeter 21",
        type: DeviceType.Multimeter,
        address: "192.168.1.163",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 2"
      ),
      Device(
        name: "Multimeter 22",
        type: DeviceType.Multimeter,
        address: "192.168.1.164",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 3"
      ),
      Device(
        name: "Multimeter 23",
        type: DeviceType.Multimeter,
        address: "192.168.1.165",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-CK (Phòng Cơ khí)"
      ),
    ]
  ),
  Msb(
    id: 4,
    title: "MSB4",
    online: true,
    deviceList: [
      Device(
        type: DeviceType.ACB,
        name: "Q4.1",
        address: "01",
        state: DeviceState.Offline,
        note: "Nguồn cấp từ MBA 04"
      ),
      Device(
        name: "Multimeter 24",
        type: DeviceType.Multimeter,
        address: "192.168.1.201",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ MBA 04"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q4.2",
        address: "02",
        state: DeviceState.Offline,
        note: "Nguồn cấp từ lộ G4 tủ Máy phát "
      ),
      Device(
        name: "Multimeter 25",
        type: DeviceType.Multimeter,
        address: "192.168.1.202",
        state: DeviceState.Offline,
        note: "Giám sát điện năng nguồn cấp từ lộ G4 tủ Máy phát "
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q4.3",
        address: "03",
        state: DeviceState.Offline,
        note: "ACB nhánh 1 của tủ MSB4"
      ),
      Device(
        type: DeviceType.ACB,
        name: "Q4.4",
        address: "04",
        state: DeviceState.Offline,
        note: "ACB nhánh 2 của tủ MSB4"
      ),
      Device(
        name: "Multimeter 26",
        type: DeviceType.Multimeter,
        address: "192.168.1.203",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-X.MỰC 1"
      ),
      Device(
        name: "Multimeter 27",
        type: DeviceType.Multimeter,
        address: "192.168.1.204",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐG (Phòng máy cắt và Đóng gói)"
      ),
      Device(
        name: "Multimeter 28",
        type: DeviceType.Multimeter,
        address: "192.168.1.205",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-DCT (Phòng máy in phủ)"
      ),
      Device(
        name: "Multimeter 29",
        type: DeviceType.Multimeter,
        address: "192.168.1.207",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện TĐ-AHU 4~7"
      ),
      Device(
        name: "Multimeter 30",
        type: DeviceType.Multimeter,
        address: "192.168.1.208",
        state: DeviceState.Offline,
        note: "Giám sát điện năng cho tủ điện HVAC-VP (Nhà văn phòng)"
      ),
    ]
  ),
];

Device? indexToDevice(int mfmIndex){
  for (final msb in listMsbSample){
    for (final device in msb.deviceList!){
      if (!device.name.startsWith("Multi")){
        continue;
      }
      final deviceIndex = int.parse(device.name.split(' ').last);
      if (deviceIndex == mfmIndex){
        return device;
      }
    }
  }
  return null;
}
