import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/devicelist/devicelist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _stackIndex = 0;
  void setStackIndex(int index){
    setState(() {
      _stackIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(
        requestChangeStackIndex: setStackIndex,
        currentStackIndex: _stackIndex,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(
                  requestChangeStackIndex: setStackIndex,
                  currentStackIndex: _stackIndex,
                ),
              ),
            Expanded(
              flex: 5, 
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Header( title: [
                      "Tổng quan", 
                      "Danh sách thiết bị",
                      "Sự kiện",
                      "Nhật ký hoạt động",
                      "Báo cáo",
                      "Quản lý tài khoản",
                      "Quản lý năng lượng",
                      "Thiết lập",
                    ][_stackIndex]),
                    SizedBox(height: defaultPadding),
                    Expanded(
                      flex: 5,
                      child: IndexedStack(
                        index: _stackIndex,
                        children: [
                          DashboardScreen(),
                          DeviceListScreen(),
                          Text("Sự kiện"),
                          Text("Nhật ký hoạt động"),
                          Text("Báo cáo"),
                          Text("Quản lý tài khoản"),
                          Text("Quản lý năng lượng"),
                          Text("Thiết lập"),
                        ],
                      )
                    ),
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
