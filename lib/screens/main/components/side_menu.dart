import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  final Function(int) requestChangeStackIndex;
  final int currentStackIndex;
  const SideMenu({
    Key? key, 
    required this.requestChangeStackIndex,
    required this.currentStackIndex
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo2.png"),
          ),
          DrawerListTile(
            title: "Tổng quan",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              requestChangeStackIndex(0);
            },
            selected: currentStackIndex == 0,
          ),
          DrawerListTile(
            title: "Danh sách thiết bị",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () { requestChangeStackIndex(1); },
            selected: currentStackIndex == 1,
          ),
          DrawerListTile(
            title: "Sự kiện",
            svgSrc: "assets/icons/menu_task.svg",
            press: () { requestChangeStackIndex(2); },
            selected: currentStackIndex == 2,
          ),
          DrawerListTile(
            title: "Nhật ký hoạt động",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () { requestChangeStackIndex(3); },
            selected: currentStackIndex == 3,
          ),
          DrawerListTile(
            title: "Báo cáo",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () { requestChangeStackIndex(4); },
            selected: currentStackIndex == 4,
          ),
          DrawerListTile(
            title: "Quản lý tài khoản",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () { requestChangeStackIndex(5); },
            selected: currentStackIndex == 5,
          ),
          DrawerListTile(
            title: "Quản lý năng lượng",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () { requestChangeStackIndex(6); },
            selected: currentStackIndex == 6,
          ),
          DrawerListTile(
            title: "Thiết lập",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () { requestChangeStackIndex(7); },
            selected: currentStackIndex == 7,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.selected
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    Color titleColor = selected ? accentColor : Colors.white54;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: titleColor,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
    );
  }
}
