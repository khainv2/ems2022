

import 'package:admin/constants.dart';
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
        readed: false,
        time: DateTime.fromMillisecondsSinceEpoch(item['createdTime'] * 1000),
        message: 'User ${item['loginname']} ${item['content']}',
        type: EventType.Info
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