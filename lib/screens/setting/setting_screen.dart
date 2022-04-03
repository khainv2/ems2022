import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text("Tên đăng nhập"),
          TextField(),
          Text("Mật khẩu"),
          TextField(),
          Text("Tên đăng nhập"),
          TextField(),
        ],
      )
    );
  }
}