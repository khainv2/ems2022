

import 'package:admin/controllers/user_control.dart';
import 'dart:convert';
import 'package:admin/controllers/user_control.dart';
import 'package:admin/models/define.dart';
import 'package:http/http.dart' as http;

Future<String> getSystemLog() async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('GET', Uri.parse('http://test.thanhnt.com:8080/api/systemlog/list'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
  return '';
}