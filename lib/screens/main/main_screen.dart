import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/devicelist/devicelist_screen.dart';
import 'package:admin/screens/energy_management/energy_managerment_screen.dart';
import 'package:admin/screens/eventlist/eventlist_screen.dart';
import 'package:admin/screens/loglist/loglist_screen.dart';
import 'package:admin/screens/report/report_screen.dart';
import 'package:admin/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';


class MainApp extends StatelessWidget {
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
      home: MultiProvider(   
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}


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
                          EventListScreen(),
                          LogListScreen(),
                          ReportScreen(),
                          EnergyManagementScreen(),
                          SettingScreen(), 
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
