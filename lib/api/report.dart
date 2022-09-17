import 'dart:convert';

import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReportOutput {
  List<String> headers = [];
  List<List<String>> rows = [];
}

Future<ReportOutput> getReport(ReportTimeMode timeMode, ReportSheetMode sheetMode, DateTime timeSearch) async {
  DateFormat dateAPIFormatter = DateFormat('yyyy-DD-mm');
  int modeAPI = 0;
  switch (timeMode){
    case ReportTimeMode.Daily: 
      modeAPI = 2; 
      dateAPIFormatter = DateFormat('yyyy-MM-dd');
      break;
    case ReportTimeMode.Monthly: 
      modeAPI = 3; 
      dateAPIFormatter = DateFormat('yyyy-MM');
      break;
    case ReportTimeMode.Yearly: 
      modeAPI = 4; 
      dateAPIFormatter = DateFormat('yyyy');
      break;
  }
  final searchPattern = dateAPIFormatter.format(timeSearch);
  List<String> devices = [];
  if (sheetMode == ReportSheetMode.Input){
    devices = [
      "MM01",
      "MM02",
      "MM07",
      "MM08",
      "MM09",
      "MM10",
      "MM24",
      "MM25",
    ];
  } else {
    devices = [
      "MM03",
      "MM04",
      "MM05",
      "MM06",
      "MM11",
      "MM12",
      "MM13",
      "MM14",
      "MM15",
      "MM16",
      "MM17",
      "MM18",
      "MM19",
      "MM20",
      "MM21",
      "MM22",
      "MM23",
      "MM26",
      "MM27",
      "MM28",
      "MM29",
      "MM30",
      "MM31",
      "MM32",
    ];
  }

  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('POST', Uri.parse('$hostname/api/report/data'));
  
  request.body = json.encode({
    "mtserials": devices,
    "reporttype": modeAPI,
    "timestr": searchPattern
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  print(request.body);
  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    final retJson = jsonDecode(ret);
    final data = retJson['data'];
    final sensors = data['sensors'];
    List<String> headers = [];
    if (sheetMode == ReportSheetMode.Input){
      if (timeMode == ReportTimeMode.Daily){
        headers = [
          "Thời gian (Giờ)",	"MBA 01",	"Lộ G1",	"MBA 02",	"Lộ G2",	"MBA 03",	"Lộ G3",	"MBA 04",	"Lộ G4"
        ];
      } else if (timeMode == ReportTimeMode.Monthly){
        headers = [
          "Thời gian (Ngày)",	"MBA 01",	"Lộ G1",	"MBA 02",	"Lộ G2",	"MBA 03",	"Lộ G3",	"MBA 04",	"Lộ G4"
        ];
      } else {
        headers = [
          "Thời gian (Tháng)",	"MBA 01",	"Lộ G1",	"MBA 02",	"Lộ G2",	"MBA 03",	"Lộ G3",	"MBA 04",	"Lộ G4"
        ];
      }
    } else {
      if (timeMode == ReportTimeMode.Daily){
        headers = [
          "Thời gian (Giờ)",	"TĐ-PAL",	"TĐ-DM",	"TĐ-CHILLER 4",	"TĐ-ĐL4",	"MÁY NÉN",	"TĐ-2",
          "TĐ-1",	"TĐ-ĐL3",	"TĐT-VP",	"TĐ-BƠM-AHU",	"TĐ-TG-T2",	"TĐ-TG-T1",	"TĐ-AHU 1~3",	"TĐ-CHILLER 2",	
          "TĐ-CK",	"TĐ-CHILLER 3",	"TĐ-CHILLER 1",	"TĐ-X.MỰC 1",	"TĐ-ĐG",	"TĐ-DCT",	"TĐ-AHU 4~7",	"HVAC-VP",	"TĐ-ĐL1",	"TĐ-ĐL2"
        ];
      } else if (timeMode == ReportTimeMode.Monthly){
        headers = [
          "Thời gian (Ngày)",	"TĐ-PAL",	"TĐ-DM",	"TĐ-CHILLER 4",	"TĐ-ĐL4",	"MÁY NÉN",	"TĐ-2",
          "TĐ-1",	"TĐ-ĐL3",	"TĐT-VP",	"TĐ-BƠM-AHU",	"TĐ-TG-T2",	"TĐ-TG-T1",	"TĐ-AHU 1~3",	"TĐ-CHILLER 2",	
          "TĐ-CK",	"TĐ-CHILLER 3",	"TĐ-CHILLER 1",	"TĐ-X.MỰC 1",	"TĐ-ĐG",	"TĐ-DCT",	"TĐ-AHU 4~7",	"HVAC-VP",	"TĐ-ĐL1",	"TĐ-ĐL2"
        ];
      } else {
        headers = [
          "Thời gian (Tháng)",	"TĐ-PAL",	"TĐ-DM",	"TĐ-CHILLER 4",	"TĐ-ĐL4",	"MÁY NÉN",	"TĐ-2",
          "TĐ-1",	"TĐ-ĐL3",	"TĐT-VP",	"TĐ-BƠM-AHU",	"TĐ-TG-T2",	"TĐ-TG-T1",	"TĐ-AHU 1~3",	"TĐ-CHILLER 2",	
          "TĐ-CK",	"TĐ-CHILLER 3",	"TĐ-CHILLER 1",	"TĐ-X.MỰC 1",	"TĐ-ĐG",	"TĐ-DCT",	"TĐ-AHU 4~7",	"HVAC-VP",	"TĐ-ĐL1",	"TĐ-ĐL2"
        ];
      }
    }

    List<List<String>> rows = [];

    int numLines = 0;
    if (timeMode == ReportTimeMode.Daily){
      numLines = 28;
    } else if (timeMode == ReportTimeMode.Monthly){
      numLines = 35;
    } else {
      numLines = 16;
    }
    for (int i = 0; i < numLines; i++){
      List<String> lines = [];
      for (int j = 0; j <= devices.length; j++){
        lines.add("");
      }
      rows.add(lines);
    }
    
    rows[numLines - 4][0] = 'Tổng';
    rows[numLines - 3][0] = 'Min';
    rows[numLines - 2][0] = 'Max';
    rows[numLines - 1][0] = 'Trung bình';
    for (final sensor in sensors){
      final name = sensor['mtserial'];
      final datalist = sensor['datalist'];
      final analytic = sensor['analytic'];
      if (!devices.contains(name)){
        continue;
      }
      int c = devices.indexOf(name) + 1;
      int r = 0;
      for (final d in datalist){
        final dTime = d['time'];
        final dValue = d['value'];
        rows[r][0] = dTime;
        rows[r][c] = dValue.toString();
        r++;
      }

      rows[numLines - 4][c] = analytic['sum'].toString();
      rows[numLines - 3][c] = analytic['min'].toString();
      rows[numLines - 2][c] = analytic['max'].toString();
      rows[numLines - 1][c] = analytic['average'].toString();
    }


    return ReportOutput()
      ..headers = headers
      ..rows = rows;    
  } else {
    print(response.reasonPhrase);
    return ReportOutput();
  }
}