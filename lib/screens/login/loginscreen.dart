import 'dart:convert';
import 'package:admin/constants.dart';
import 'package:admin/controllers/user_control.dart';
import 'package:admin/models/define.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMS',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: LoginScreen()
    );
  }
}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$hostname/api/auth/login'));
    request.body = json.encode({
      "username": "admin",
      "password": "admin",
      // "username": data.name,
      // "password": data.password,
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
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Hệ thống giám sát điện năng',
      onLogin: _authUser,
      disableCustomPageTransformer: true,
      onSignup: (val){},
      onRecoverPassword: (val){},
      logo: 'assets/images/logo2.png',
      passwordValidator: (text) => null,    
      hideForgotPasswordButton: true,  
      hideSignUpButton: true,
      theme: LoginTheme(
        accentColor: accentColor,
        primaryColor: bgColor,
        cardTheme: CardTheme(
          margin: EdgeInsets.all(80),
          color: secondaryColor,
        ),
        pageColorDark: bgColor
      ),
      userValidator: (val){
        return null;
      },
      messages: LoginMessages(
        flushbarTitleError: "Lỗi",
        flushbarTitleSuccess: "Đăng nhập thành công",
        userHint: 'Tên đăng nhập',
        passwordHint: 'Mật khẩu', 
        loginButton: 'Đăng nhập',
        confirmPasswordError: 'Mật khẩu chưa đúng',
        confirmPasswordHint: 'Mật khẩu',
        forgotPasswordButton: 'Quên mật khẩu',
        goBackButton: 'Quay lại',
        signupButton: 'Đăng ký', 
        recoverPasswordButton: '',
        recoverPasswordDescription: '',
        recoverPasswordIntro: '',
        recoverPasswordSuccess: ''
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainApp(),
        ));
      },
    );
  }
}
