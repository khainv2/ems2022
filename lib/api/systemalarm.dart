

import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'dart:convert';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
import 'package:http/http.dart' as http;

class AlarmResult {
  bool ok = false;
  List<Event> eventList = [];
  int currentPage = 1;
  int totalPage = 1;
  int total = 1;
  int pageSize = 1;
}

class AlarmCount {
  bool ok = true;
  int high = 0;
  int med = 0;
  int low = 0;
  int get total => high + med + low;
}

Future<AlarmCount> getCountUnhanded() async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('GET', Uri.parse('$hostname/api/alarm/countUnhandled'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    final data = json.decode(ret);
    final d = data['data'];
    return AlarmCount()
      ..ok = true
      ..high = d['highAlarmCount']
      ..med = d['midAlarmCount']
      ..low = d['lowAlarmCount'];
  } else {
    print(response.reasonPhrase);
    return AlarmCount() ..ok = false;
  }
}

Future<void> markReadedSystemAlarm(String id) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('PUT', Uri.parse('$hostname/api/alarm/act/$id'));
  request.body = json.encode({
    "ishandled": true
  });
  request.headers.addAll(headers);

  print('Set marked to system alarm $id');

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    final data = json.decode(ret);
    final d = data['data'];
  }
  else {
    print(response.reasonPhrase);
  }

}

Future<AlarmResult> getSystemAlarm(int pageIndex, int pageSize) async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  String url = '$hostname/api/alarm/list';
  if (pageSize > 0){
    url += '/p/$pageIndex/s/$pageSize';
  }
  var request = http.Request('GET', Uri.parse(url));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    final logResult = AlarmResult();
    logResult.ok = true;
    final data = json.decode(ret);
    final d = data['data'];
    final pagination = d["pagination"];
    logResult.currentPage = pagination["current"];
    logResult.totalPage = pagination["totalPage"];
    logResult.total = pagination["total"];
    logResult.pageSize = pagination["pageSize"];
    
    final list = d['list'];
    int index = 0;
    for (final item in list){
      
      final e = Event(
        num: (logResult.currentPage - 1) * logResult.pageSize + index + 1,
        readed: item['ishandled'],
        time: DateTime.fromMillisecondsSinceEpoch(item['createdTime'] * 1000),
        message: '${item['content']}',
        type: EventType.Info,
        level: getLevelFromValue(item['alarmtype']),
        ruleName: item['rulename'],
        device: item['mtname'],
        id: item['id']
      );
      logResult.eventList.add(e);
      index++;
    }
    // print('event list size ${logResult.eventList.length}');

    return logResult;
  }
  else {
    print(response.reasonPhrase);
    return AlarmResult()
      ..ok = false;
  }
}