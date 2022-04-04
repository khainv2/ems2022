import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  Widget textFieldPass(){
    return TextField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        border: OutlineInputBorder( 
          borderSide: BorderSide(
            color: Colors.teal
          )
        ),
      )
    );
      
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Container(
        width: 400,
        child: Column(
          children: [
            Text("Mật khẩu cũ"),
            textFieldPass(),
            SizedBox(height: defaultPadding,),
            Text("Mật khẩu mới"),
            textFieldPass(),
            SizedBox(height: defaultPadding,),
            Text("Nhập lại mật khẩu"),
            textFieldPass(),
            SizedBox(height: defaultPadding,),
            ElevatedButton(onPressed: (){}, child: Text("Đổi mật khẩu"))
          ],
        )
      )
    );
  }
}