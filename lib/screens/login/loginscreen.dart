import 'dart:convert';
import 'package:admin/api/auth.dart';
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
    return login(data.name, data.password);
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