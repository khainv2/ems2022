import 'dart:convert';
import 'package:admin/constants.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:http/http.dart' as http;

Future<String> login(String username, String password) async {
    print('[Auth] Login with username: $username, password: $password');

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$hostname/api/auth/login'));
    request.body = json.encode({
      // "username": "admin",
      // "password": "admin",
      "username": username,
      "password": password,
      "req_page": ""
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final ret = await response.stream.bytesToString();
      print(ret);
      final data = json.decode(ret);
      if (data['success']){
        final userControl = UserControl();
        final d = data['data'];
        userControl.name = d['user']['fullname'];
        userControl.username = d['user']['username'];
        userControl.role = d['user']['roledesc'];
        userControl.token = d['token'];
        return '';
      } else {
        return 'Tên đăng nhập hoặc mật khẩu sai';
      }
    } else {
      print(response.reasonPhrase);
      return 'Tên đăng nhập hoặc mật khẩu sai';
    }
  }