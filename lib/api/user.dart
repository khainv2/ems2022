

import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'dart:convert';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
import 'package:admin/models/userinfo.dart';
import 'package:admin/models/userpermission.dart';
import 'package:http/http.dart' as http;

class UserInfoResult {
  bool ok = false;
  List<UserInfo> userlist = [];
  int currentPage = 1;
  int totalPage = 1;
  int total = 1;
  int pageSize = 1;
}

Future<UserInfoResult> getUserList(int pageIndex, int pageSize) async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  String url = '$hostname/api/usermanagement/users';
  if (pageSize > 0){
    url += '/p/$pageIndex/s/$pageSize';
  }
  var request = http.Request('GET', Uri.parse(url));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    final logResult = UserInfoResult();
    logResult.ok = true;
    final data = json.decode(ret);
    final d = data['data'];
    final pagination = d["pagination"];
    logResult.currentPage = pagination["current"];
    logResult.totalPage = pagination["totalPage"];
    logResult.total = pagination["total"];
    logResult.pageSize = pagination["pageSize"];    
    final list = d['list'];
    for (final item in list){
      final role = item['role'];
      var p = UserPermission.Viewer;
      if (role == 0) p = UserPermission.Admin;
      if (role == 1) p = UserPermission.Operator;
      var e = UserInfo(
        item['username'],
        item['fullname'],
        p
      );
      e.phone = item['phone'];
      e.email = item['email'];
      e.active = item['active'];
      e.id = item['id'];
      logResult.userlist.add(e);
    }
    return logResult;
  }
  else {
    print(response.reasonPhrase);
    return UserInfoResult()
      ..ok = false;
  }
}

Future<bool> createUser(UserInfo info) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };

  var request = http.Request('POST', Uri.parse('$hostname/api/usermanagement/users'));

  int p = 2;
  if (info.userPermission == UserPermission.Admin){
    p = 0;
  } else if (info.userPermission == UserPermission.Operator){
    p = 1;
  }
  request.body = json.encode({
    "username": info.username,
    "password": info.password,
    "role": p,
    "fullname": info.displayName,
    "phone": info.phone,
    "email": info.email
  });
  request.headers.addAll(headers);


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print('Create user ok');
    return true;
  } else {
    print('create user failed');
    print(response.reasonPhrase);
    return false;
  }
}


Future<bool> updateUser(UserInfo info) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };

  var request = http.Request('PUT', Uri.parse('$hostname/api/usermanagement/users/${info.username}'));

  int p = 2;
  if (info.userPermission == UserPermission.Admin){
    p = 0;
  } else if (info.userPermission == UserPermission.Operator){
    p = 1;
  }
  request.body = json.encode({
    "password": info.password,
    "role": p,
    "fullname": info.displayName,
    "phone": info.phone,
    "email": info.email,
    "active": true,
  });
  request.headers.addAll(headers);

  print('request ${request} ${request.body} ${request.headers}');

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print('Update user ok');
    return true;
  } else {
    print('Update user failed');
    print(response.reasonPhrase);
    return false;
  }
}





Future<bool> removeUser(String username) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };

  var request = http.Request('DELETE', Uri.parse('$hostname/api/usermanagement/users/$username'));
request.headers.addAll(headers);

  print('request ${request} ${request.body} ${request.headers}');

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print('Delete user ok');
    return true;
  } else {
    print('Delete user failed');
    print(response.reasonPhrase);
    return false;
  }
}




