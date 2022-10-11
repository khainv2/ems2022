import 'dart:async';

import 'package:admin/common.dart';
import 'package:admin/controllers/menucontroller.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/admin/adminpage.dart';
import 'package:admin/screens/alarm_rule/alarm_rule_screen.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/devicelist/devicelist_screen.dart';
import 'package:admin/screens/energy_management/energy_management_screen.dart';
import 'package:admin/screens/eventlist/eventlist_screen.dart';
import 'package:admin/screens/loglist/loglist_screen.dart';
import 'package:admin/screens/report/report_screen.dart';
import 'package:admin/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/side_menu.dart';

class ScreenData {
  String name;
  String image;
  Widget screen;
  ScreenData({ required this.name, required this.image, required this.screen });
}

int get overviewIndex => 0;
int get deviceListIndex => 1;
int get eventListIndex => 2;
int get alarmRuleIndex => 3;
int get logListIndex => 4;
int get reportIndex => 5;
int get energyManagementIndex => 6;
int get settingIndex => 7;

var screenList = [
  ScreenData(
    name: "Tổng quan",
    image: "assets/icons/menu_dashbord.svg",
    screen: DashboardScreen(),
  ),
  ScreenData(
    name: "Danh sách thiết bị",
    image: "assets/icons/menu_tran.svg",
    screen: DeviceListScreen(),
  ),
  ScreenData(
    name: "Sự kiện",
    image: "assets/icons/menu_task.svg",
    screen: EventListScreen(),
  ),
  ScreenData(
    name: "Cấu hình cảnh báo",
    image: "assets/icons/menu_store.svg",
    screen: AlarmRuleScreen(),
  ),
  ScreenData(
    name: "Nhật ký hoạt động",
    image: "assets/icons/menu_doc.svg",
    screen: LogListScreen(),
  ),
  ScreenData(
    name: "Báo cáo",
    image: "assets/icons/menu_notification.svg",
    screen: ReportScreen(),
  ),
  ScreenData(
    name: "Quản lý năng lượng",
    image: "assets/icons/menu_doc.svg",
    screen: EnergyManagementScreen(),
  ),
  ScreenData(
    name: "Tài khoản",
    image: "assets/icons/menu_setting.svg",
    screen: AdminPage(),
  ),
];

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('vi')
      ],
      debugShowCheckedModeBanner: false,
      title: 'EMS',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme)
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
    final userControl = UserControl();
    if (userControl.role != "Administrator" && index == settingIndex){
        context.read<MenuController>().closeMenu();
        final snackBar = SnackBar(
          content: Text(
            'Chỉ Quản trị viên mới có quyền truy cập quản lý tài khoản'
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
    }
    setState(() {
      _stackIndex = index;
    });
    userControl.setCurrentStackIndex(index);
  }

  @override
  void initState(){
    super.initState();
    final userControl = UserControl();
    
    // Timer(Duration(seconds: 1), (){
    //   setStackIndex(reportIndex );
    // });
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
                padding: EdgeInsets.all(defaultHalfPadding),
                child: Column(
                  children: [
                    Header(
                      title: screenList[_stackIndex].name,
                      notificationClicked: (){
                        setStackIndex(eventListIndex);
                      },
                    ),
                    SizedBox(height: defaultHalfPadding),
                    Expanded(
                      flex: 5,
                      child: IndexedStack(
                        index: _stackIndex,
                        children: screenList.map((e) => e.screen).toList(),
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
