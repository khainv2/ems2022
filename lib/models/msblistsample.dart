import 'device.dart';
import 'msb.dart';

var listMsbSample = [
  Msb(
    id: 1,
    title: "MSB1",
    online: false,
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
        id: 5,
        name: "Multimeter 1",
        model: "EEM-MA 770",
        address: "192.168.1.51",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ MBA 01"
      ),
      Device(
        id: 2,
        name: "ACB",
        model: "Q1.2",
        modbusAddress: "02",
        online: false,
        note: "Nguồn cấp từ lộ G1 tủ Máy phát"
      ),
      Device(
        id: 6,
        name: "Multimeter 2",
        model: "EEM-MA 770",
        address: "192.168.1.52",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ lộ G1 tủ Máy phát "
      ),
      Device(
        id: 3,
        name: "ACB",
        model: "Q1.3",
        modbusAddress: "03",
        online: false,
        note: "ACB liên lạc giữa tủ MSB1 với MSB2"
      ),
      Device(
        id: 4,
        name: "ACB",
        model: "Q1.4",
        modbusAddress: "04",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL1 (Phòng máy in phủ)"
      ),
      Device(
        id: 7,
        name: "Multimeter 3",
        model: "EEM-MA 770",
        address: "192.168.1.53",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-PAL (Kho Pallet)"
      ),
      Device(
        id: 8,
        name: "Multimeter 4",
        model: "EEM-MA 770",
        address: "192.168.1.54",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-DM (Phòng Rửa-Dung môi)"
      ),
      Device(
        id: 8,
        name: "Multimeter 5",
        model: "EEM-MA 770",
        address: "192.168.1.55",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 4"
      ),
      Device(
        id: 8,
        name: "Multimeter 6",
        model: "EEM-MA 770",
        address: "192.168.1.56",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL4 (Phòng máy in Tầng 2)"
      ),
    ]
  ),
  Msb(
    id: 2,
    title: "MSB2",
    online: false,
    deviceList: [
      Device(
        id: 1,
        name: "ACB",
        model: "Q2.1",
        modbusAddress: "01",
        online: false,
        note: "Nguồn cấp từ MBA 02"
      ),
      Device(
        id: 1,
        name: "Multimeter 7",
        model: "EEM-MA 770",
        address: "192.168.1.101",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ MBA 02"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q2.2",
        modbusAddress: "02",
        online: false,
        note: "Đầu vào từ lộ G2 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "Multimeter 8",
        model: "EEM-MA 770",
        address: "192.168.1.102",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ lộ G2 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q2.3",
        modbusAddress: "03",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL2 (Phòng máy in phủ)"
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
        online: false,
        note: "Nguồn cấp từ MBA 03"
      ),
      Device(
        id: 1,
        name: "Multimeter 9",
        model: "EEM-MA 770",
        address: "192.168.1.151",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ MBA 03"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.2",
        modbusAddress: "02",
        online: false,
        note: "Đầu vào từ lộ G3 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "Multimeter 10",
        model: "EEM-MA 770",
        address: "192.168.1.152",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ lộ G3 tủ Máy phát"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.3",
        modbusAddress: "03",
        online: false,
        note: "ACB liên lạc MSB3 vs MSB4"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q3.5",
        modbusAddress: "04",
        online: false,
        note: "ACB nhánh của tủ MSB3"
      ),
      Device(
        id: 1,
        name: "Multimeter 11",
        model: "EEM-MA 770",
        address: "192.168.1.153",
        online: false,
        note: "Giám sát điện năng cho tủ điện MÁY NÉN"
      ),
      Device(
        id: 1,
        name: "Multimeter 12",
        model: "EEM-MA 770",
        address: "192.168.1.154",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-2"
      ),
      Device(
        id: 1,
        name: "Multimeter 13",
        model: "EEM-MA 770",
        address: "192.168.1.155",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-1"
      ),
      Device(
        id: 1,
        name: "Multimeter 14",
        model: "EEM-MA 770",
        address: "192.168.1.156",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐL3 (Phòng máy Thổi màng)"
      ),
      Device(
        id: 1,
        name: "Multimeter 15",
        model: "EEM-MA 770",
        address: "192.168.1.157",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐT-VP (Nhà văn phòng)"
      ),
      Device(
        id: 1,
        name: "Multimeter 16",
        model: "EEM-MA 770",
        address: "192.168.1.158",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-BƠM-AHU"
      ),
      Device(
        id: 1,
        name: "Multimeter 17",
        model: "EEM-MA 770",
        address: "192.168.1.159",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-TG-T2"
      ),
      Device(
        id: 1,
        name: "Multimeter 18",
        model: "EEM-MA 770",
        address: "192.168.1.160",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-TG-T1"
      ),
      Device(
        id: 1,
        name: "Multimeter 19",
        model: "EEM-MA 770",
        address: "192.168.1.161",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-AHU 1~3"
      ),
      Device(
        id: 1,
        name: "Multimeter 20",
        model: "EEM-MA 770",
        address: "192.168.1.162",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 1"
      ),
      Device(
        id: 1,
        name: "Multimeter 21",
        model: "EEM-MA 770",
        address: "192.168.1.163",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 2"
      ),
      Device(
        id: 1,
        name: "Multimeter 22",
        model: "EEM-MA 770",
        address: "192.168.1.164",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-CHILLER 3"
      ),
      Device(
        id: 1,
        name: "Multimeter 23",
        model: "EEM-MA 770",
        address: "192.168.1.165",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-CK (Phòng Cơ khí)"
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
        online: false,
        note: "Nguồn cấp từ MBA 04"
      ),
      Device(
        id: 1,
        name: "Multimeter 24",
        model: "EEM-MA 770",
        address: "192.168.1.201",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ MBA 04"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.2",
        modbusAddress: "02",
        online: false,
        note: "Nguồn cấp từ lộ G4 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "Multimeter 25",
        model: "EEM-MA 770",
        address: "192.168.1.202",
        online: false,
        note: "Giám sát điện năng nguồn cấp từ lộ G4 tủ Máy phát "
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.3",
        modbusAddress: "03",
        online: false,
        note: "ACB nhánh 1 của tủ MSB4"
      ),
      Device(
        id: 1,
        name: "ACB",
        model: "Q4.4",
        modbusAddress: "04",
        online: false,
        note: "ACB nhánh 2 của tủ MSB4"
      ),
      Device(
        id: 1,
        name: "Multimeter 26",
        model: "EEM-MA 770",
        address: "192.168.1.203",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-X.MỰC 1"
      ),
      Device(
        id: 1,
        name: "Multimeter 27",
        model: "EEM-MA 770",
        address: "192.168.1.204",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-ĐG (Phòng máy cắt và Đóng gói)"
      ),
      Device(
        id: 1,
        name: "Multimeter 28",
        model: "EEM-MA 770",
        address: "192.168.1.205",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-DCT (Phòng máy in phủ)"
      ),
      Device(
        id: 1,
        name: "Multimeter 29",
        model: "EEM-MA 770",
        address: "192.168.1.207",
        online: false,
        note: "Giám sát điện năng cho tủ điện TĐ-AHU 4~7"
      ),
      Device(
        id: 1,
        name: "Multimeter 30",
        model: "EEM-MA 770",
        address: "192.168.1.208",
        online: false,
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
    return null;
  }
}
