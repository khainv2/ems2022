import 'package:admin/constants.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HistoryParam {
  int time;
  double value;
  HistoryParam(this.time, this.value);
}

class HistoryDevice {
  // Key là tên param
  Map<String, List<HistoryParam>> data = {};
}
Future<HistoryDevice> getFullHistoryDevice(String deviceSerial, List<String> paramList, int startTime, int stopTime) async {
  final output = HistoryDevice();
  for (final param in paramList){
    final historyParam = await getHistory(deviceSerial, param, startTime, stopTime);
    output.data[param] = historyParam;
  }
  return output;
}

Future<List<HistoryParam>> getHistory(String deviceSerial, String param, int startTime, int stopTime) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}',
    'Access-Control-Allow-Origin': '*'
  };
  var request = http.Request('POST', Uri.parse('$hostname/api/datamonitor/meterHistory'));
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
    // if (output.length > 0){
    //   final formatter = DateFormat('hh:mm');
    //   print('First time' + formatter.format(DateTime.fromMillisecondsSinceEpoch(output[0].time * 1000)));

    // }
    return output;
  } else {
    print(response.reasonPhrase);
    return [];
  }
}