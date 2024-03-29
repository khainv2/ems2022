import 'dart:async';

import 'package:admin/api/systemalarm.dart';
import 'package:admin/controllers/menucontroller.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../common.dart';
import 'package:badges/badges.dart';

/// Mô tả tiêu đề phía trên của app / web
class Header extends StatelessWidget {
  final String title;
  final Function() notificationClicked;
  const Header({
    Key? key, required this.title, required this.notificationClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
          SizedBox(width: defaultPadding),
        if (!Responsive.isMobile(context))
          Image.asset(
            "assets/images/logo3.png", 
            width: 42,
            height: 42,
            fit: BoxFit.fitWidth,
          ),
        SizedBox(width: defaultPadding),

        if (MediaQuery.of(context).size.width > 1200)
          Text(
            "HỆ THỐNG GIÁM SÁT NĂNG LƯỢNG NHÀ MÁY VẬT LIỆU POLYMER CÔNG NGHỆ CAO", 
            style: TextStyle(
              fontSize: 17,
              color: primaryColor
            ),
          ),
        SizedBox(width: defaultPadding),
        if (!Responsive.isMobile(context))
          Image.asset(
            "assets/images/logo4.png", 
            width: 80,
            height: 42,
            // color: primaryColor,
            // colorBlendMode: BlendMode.darken,
            fit: BoxFit.fitWidth,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: Container()),
        NotificationButton(onPressed: notificationClicked),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_account.png",
            height: 28,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(UserControl().name),
            ),
          PopupMenuButton(
            icon: Icon(Icons.keyboard_arrow_down),
            onSelected: (value) {
              if (value == '/signout'){
                print('Sign out');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginApp()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  child: Text("Tài khoản"),
                  value: '/account',
                ),
                PopupMenuItem(
                  child: Text("Đăng xuất"),
                  value: '/signout',
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}

class NotificationButton extends StatefulWidget {
  final Function() onPressed;
  NotificationButton({required this.onPressed });
  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  Timer? timerQueryData;
  AlarmCount? _alarmCount;

  void getDataFromServer(){
    getCountUnhanded().then((alarmCount){
      setState(() {
        _alarmCount = alarmCount;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    const oneSec = Duration(seconds: 5);
    timerQueryData = Timer.periodic(oneSec, (Timer t) => getDataFromServer());   
  }

  @override
  void dispose(){
    super.dispose();
    if (timerQueryData != null){
      timerQueryData!.cancel();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    int countNotification = _alarmCount == null ? 0 : _alarmCount!.total;
    if (countNotification == 0){
      return TextButton(
        child: Icon(Icons.notifications),
        onPressed: widget.onPressed,
      );
    } else {
      return Badge(
        badgeContent: Text(countNotification.toString()),
        child: TextButton(
          child: Icon(Icons.notifications),
          onPressed: widget.onPressed,
        )
      );
    }
    
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Tìm kiếm",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
