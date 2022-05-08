import 'package:admin/constants.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryParam {
  int time;
  double value;
  HistoryParam(this.time, this.value);
}

Future<List<HistoryParam>> getHistory(String deviceSerial, String param, int startTime, int stopTime) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('POST', Uri.parse('http://test.thanhnt.com:8080/api/datamonitor/meterHistory'));
  request.body = json.encode({
    "mtserial": deviceSerial,
    "paramname": param,
    "starttime": startTime,
    "endtime": stopTime
  });
  request.headers.addAll(headers);
  print('Get history with device $deviceSerial, param $param, startTime $startTime, endtime $stopTime');

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    final retJson = jsonDecode(ret);
    final datalist = retJson['data']['datalist'];
    List<HistoryParam> output = [];
    for (final e in datalist){
      output.add(HistoryParam(e["createTime"], e["value"]));
    }
    return output;
  }
  else {
    print(response.reasonPhrase);
    return [];
  }
}