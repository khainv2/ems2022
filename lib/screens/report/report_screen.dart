import 'dart:io';

import 'package:admin/api/report.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msblistsample.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import '../../common.dart';



class ReportScreen extends StatefulWidget {
  const ReportScreen({ Key? key }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}
class _ReportScreenState extends State<ReportScreen> {
  ReportTimeMode timeMode = ReportTimeMode.Daily;
  ReportSheetMode sheetMode = ReportSheetMode.Input;

  DateTime timeSearch = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  List<String> myheaders = ['Đang cập nhật'];
  List<List<String>> myrows = [];
  
  @override 
  void initState(){
    super.initState();
    final userControl = UserControl();
    userControl.addStackIndexChangeListener((index){
      if (index == reportIndex){
        downloadSheetAndUpdate();
      }
    });
  }

  void downloadSheetAndUpdate(){
    getReport(timeMode, sheetMode, timeSearch).then((value){
      setState(() {
        myheaders = value.headers;
        myrows = value.rows;
      });
    });
  }

  Widget reportTimeModeDropdown(){
    return Container(
      width: 120,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0, 
            style: BorderStyle.solid,
            color: Colors.white54
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<ReportTimeMode>(
            elevation: 62,
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: primaryColor,
            ),
            value: timeMode,
            items: [
              DropdownMenuItem<ReportTimeMode>(
                child: Text('Theo ngày'),
                value: ReportTimeMode.Daily
              ),
              DropdownMenuItem<ReportTimeMode>(
                child: Text('Theo tháng'),
                value: ReportTimeMode.Monthly
              ),
              DropdownMenuItem<ReportTimeMode>(
                child: Text('Theo năm'),
                value: ReportTimeMode.Yearly
              ),
            ],
            onChanged: (val){
              setState(() {
                if (val == null) 
                  return;
                timeMode = val;
              });
              downloadSheetAndUpdate();
            },
          )
        ),
      ),
    );
  }

  Widget reportSheetModeDropdown(){
    return Container(
      width: 170,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0, 
            style: BorderStyle.solid,
            color: Colors.white54
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<ReportSheetMode>(
            elevation: 62,
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: primaryColor,
            ),
            value: sheetMode,
            items: [
              DropdownMenuItem<ReportSheetMode>(
                child: Text('Điện năng đầu vào'),
                value: ReportSheetMode.Input
              ),
              DropdownMenuItem<ReportSheetMode>(
                child: Text('Chi tiết phụ tải'),
                value: ReportSheetMode.Load
              ),
            ],
            onChanged: (val){
              setState(() {
                if (val == null) 
                  return;
                sheetMode = val;
              });
              downloadSheetAndUpdate();
            },
          )
        ),
      ),
    );
  }

  Widget monthSelectionDropdown(){
    List<int> monthList = [
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    ];
    return Container(
      width: 120,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0, 
            style: BorderStyle.solid,
            color: Colors.white54
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<int>(
            elevation: 62,
            style: const TextStyle(color: primaryColor),
            underline: Container(
              height: 2,
              color: primaryColor,
            ),
            value: timeSearch.month,
            items: monthList.map((e) => DropdownMenuItem<int>( child: Text('Tháng $e'), value: e)).toList(),
            onChanged: (val){
              setState(() {
                if (val == null) 
                  return;
                timeSearch = DateTime(timeSearch.year, val, timeSearch.day);
              });
              downloadSheetAndUpdate();
            },
          )
        )
      )
    );
  }

  Widget yearSelectionDropdown(){
    List<int> yearList = [];
    for (int i = 2021; i < 2030; i++){
      yearList.add(i);
    }
    return Container(
      width: 120,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0, 
            style: BorderStyle.solid,
            color: Colors.white54
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<int>(
            elevation: 62,
            style: const TextStyle(color: primaryColor),
            underline: Container(
              height: 2,
              color: primaryColor,
            ),
            value: timeSearch.year,
            items: yearList.map((e) => DropdownMenuItem<int>( child: Text('Năm $e'), value: e)).toList(),
            onChanged: (val){
              setState(() {
                if (val == null) 
                  return;
                timeSearch = DateTime(val, timeSearch.month, timeSearch.day);
              });
              downloadSheetAndUpdate();
            },
          )
        )
      )
    );
  }

  Widget monthlyButton(){
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          monthSelectionDropdown(),
          SizedBox(width: defaultHalfPadding),
          yearSelectionDropdown(),
        ],
      )
    );
  }
  Widget yearlyButton(){
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          yearSelectionDropdown(),
        ],
      )
    );
  }

  Widget dateTimeButton(){
    return Container(
      width: 130,
      height: 40,
      child: OutlinedButton(
        child: Row(
          children: [
            Icon(Icons.calendar_month),
            Text(fullDateFormatter.format(timeSearch))
          ],
        ),
        onPressed: (){
          showDatePicker(
            context: this.context, 
            initialDate: DateTime.now(), 
            firstDate: DateTime(2015, 8), 
            lastDate: DateTime(2101),
            cancelText: 'Bỏ qua',
            confirmText: 'Xác nhận',
            currentDate: timeSearch,
            locale: Locale('vi', 'VN')
          ).then((value){
            print('pick time');
            if (value != null){
              setState(() {
                timeSearch = DateTime(
                  value.year,
                  value.month,
                  value.day,
                );
                downloadSheetAndUpdate();
              });
              // getHistoryData();
            }
          });
        },
      )
    );
  }

  Widget downloadButton(){
    return SizedBox(
      width: 120, height: 36,
      child: ElevatedButton(
        onPressed: (){
          String sheetModeName = sheetMode == ReportSheetMode.Input ? 'DIEN NANG DAU VAO' : 'CHI TIET PHU TAI';
          String timeModeName = '';
          switch (timeMode) {
            case ReportTimeMode.Daily: timeModeName = 'Daily'; break;
            case ReportTimeMode.Monthly: timeModeName = 'Monthly'; break;
            case ReportTimeMode.Yearly: timeModeName = 'Yearly'; break;
            default:
          }
          String filename = 'NHÀ MÁY VẬT LIỆU POLYMER CÔNG NGHỆ CAO - $sheetModeName - $timeModeName';
          var excel = Excel.createExcel();
          var sheet = excel['Sheet1'];
          sheet.appendRow(['NHÀ MÁY VẬT LIỆU POLYMER CÔNG NGHỆ CAO']);
          sheet.appendRow(['CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM']);
          sheet.appendRow(['BÁO CÁO ĐIỆN NĂNG', '', '', 'ĐƠN VỊ WH']);
          sheet.appendRow(myheaders);
          for (final row in myrows){
            sheet.appendRow(row);
          }
          excel.save(fileName: "$filename.xlsx");
        }, 
        child: Text('Tải về')
      ),
    );
  }

  Widget sheet(BuildContext context){
    // List<String> headers = [];
    // List<List<String>> rows = [];

    // if (sheetMode == ReportSheetMode.Input){
    //   if (timeMode == ReportTimeMode.Daily){
    //     headers = [
    //       "Thời gian (Giờ)",	"MBA 01",	"Lộ G1",	"MBA 02",	"Lộ G2",	"MBA 03",	"Lộ G3",	"MBA 04",	"Lộ G4",	"NĂNG LƯỢNG ĐẦU VÀO"
    //     ];
    //     for (int i = 0; i < 24; i++){
    //       List<String> cells = [ '$i'];
    //       for (int j = 0; j < headers.length - 1; j++){
    //         cells.add('0.0');
    //       }
    //       rows.add(cells);
    //     }
    //   } else if (timeMode == ReportTimeMode.Monthly){
    //     headers = [
    //       "Thời gian (Ngày)",	"MBA 01",	"Lộ G1",	"MBA 02",	"Lộ G2",	"MBA 03",	"Lộ G3",	"MBA 04",	"Lộ G4",	"NĂNG LƯỢNG ĐẦU VÀO"
    //     ];
    //     for (int i = 1; i <= 31; i++){
    //       List<String> cells = [ '$i'];
    //       for (int j = 0; j < headers.length - 1; j++){
    //         cells.add('0.0');
    //       }
    //       rows.add(cells);
    //     }
    //   } else {
    //     headers = [
    //       "Thời gian (Tháng)",	"MBA 01",	"Lộ G1",	"MBA 02",	"Lộ G2",	"MBA 03",	"Lộ G3",	"MBA 04",	"Lộ G4",	"NĂNG LƯỢNG ĐẦU VÀO"
    //     ];
    //     for (int i = 1; i <= 12; i++){
    //       List<String> cells = [ '$i'];
    //       for (int j = 0; j < headers.length - 1; j++){
    //         cells.add('0.0');
    //       }
    //       rows.add(cells);
    //     }
    //   }
    // } else {
    //   if (timeMode == ReportTimeMode.Daily){
    //     headers = [
    //       "Thời gian (Giờ)",	"TĐ-PAL",	"TĐ-DM",	"TĐ-CHILLER 4",	"TĐ-ĐL4",	"MÁY NÉN",	"TĐ-2",
    //       "TĐ-1",	"TĐ-ĐL3",	"TĐT-VP",	"TĐ-BƠM-AHU",	"TĐ-TG-T2",	"TĐ-TG-T1",	"TĐ-AHU 1~3",	"TĐ-CHILLER 2",	
    //       "TĐ-CK",	"TĐ-CHILLER 3",	"TĐ-CHILLER 1",	"TĐ-X.MỰC 1",	"TĐ-ĐG",	"TĐ-DCT",	"TĐ-AHU 4~7",	"HVAC-VP",	"TĐ-ĐL1",	"TĐ-ĐL2"
    //     ];
    //     for (int i = 0; i < 24; i++){
    //       List<String> cells = [ '$i'];
    //       for (int j = 0; j < headers.length - 1; j++){
    //         cells.add('0.0');
    //       }
    //       rows.add(cells);
    //     }
    //   } else if (timeMode == ReportTimeMode.Monthly){
    //     headers = [
    //       "Thời gian (Ngày)",	"TĐ-PAL",	"TĐ-DM",	"TĐ-CHILLER 4",	"TĐ-ĐL4",	"MÁY NÉN",	"TĐ-2",
    //       "TĐ-1",	"TĐ-ĐL3",	"TĐT-VP",	"TĐ-BƠM-AHU",	"TĐ-TG-T2",	"TĐ-TG-T1",	"TĐ-AHU 1~3",	"TĐ-CHILLER 2",	
    //       "TĐ-CK",	"TĐ-CHILLER 3",	"TĐ-CHILLER 1",	"TĐ-X.MỰC 1",	"TĐ-ĐG",	"TĐ-DCT",	"TĐ-AHU 4~7",	"HVAC-VP",	"TĐ-ĐL1",	"TĐ-ĐL2"
    //     ];
    //     for (int i = 1; i <= 31; i++){
    //       List<String> cells = [ '$i'];
    //       for (int j = 0; j < headers.length - 1; j++){
    //         cells.add('0.0');
    //       }
    //       rows.add(cells);
    //     }
    //   } else {
    //     headers = [
    //       "Thời gian (Tháng)",	"TĐ-PAL",	"TĐ-DM",	"TĐ-CHILLER 4",	"TĐ-ĐL4",	"MÁY NÉN",	"TĐ-2",
    //       "TĐ-1",	"TĐ-ĐL3",	"TĐT-VP",	"TĐ-BƠM-AHU",	"TĐ-TG-T2",	"TĐ-TG-T1",	"TĐ-AHU 1~3",	"TĐ-CHILLER 2",	
    //       "TĐ-CK",	"TĐ-CHILLER 3",	"TĐ-CHILLER 1",	"TĐ-X.MỰC 1",	"TĐ-ĐG",	"TĐ-DCT",	"TĐ-AHU 4~7",	"HVAC-VP",	"TĐ-ĐL1",	"TĐ-ĐL2"
    //     ];
    //     for (int i = 1; i <= 12; i++){
    //       List<String> cells = [ '$i'];
    //       for (int j = 0; j < headers.length - 1; j++){
    //         cells.add('0.0');
    //       }
    //       rows.add(cells);
    //     }
    //   }
    // }

    // for (int i = 0; i < 4; i++){
    //   String title = '';
    //   if (i == 0) title = 'Tổng';
    //   if (i == 1) title = 'Min';
    //   if (i == 2) title = 'Max';
    //   if (i == 3) title = 'Trung bình';
      
    //   List<String> cells = [ title];
    //   for (int j = 0; j < headers.length - 1; j++){
    //     cells.add('0.0');
    //   }
    //   rows.add(cells);
    // }

    // myheaders = headers;
    // myrows = rows;  

    final headers = myheaders;
    final rows = myrows;   

    if (sheetMode == ReportSheetMode.Input){
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          primary: false,
          child: Container(
            width: double.infinity,
            child: DataTable(
              
              headingRowHeight: Responsive.isMobile(context) ? 36 : 48,
              dataRowHeight: Responsive.isMobile(context) ? 36 : 48,
              border: defaultTableBorder,
              headingRowColor: defaultHeaderBackground,
              columnSpacing: defaultPadding,
              showCheckboxColumn: false,
              columns: headers.map((title) => DataColumn(
                  label: Expanded(
                    child: Text(title, style: defaultTableHeaderStyle)
                  )
                )
              ).toList(),
              rows: myrows.map((e){
                final cells = e.map((f) => DataCell(Text(f))).toList();
                return DataRow(cells: cells);
              }).toList()
            ),
          )
        )
      );
    } else {
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          primary: false,
          child: Container(
            width: double.infinity,
            child: DataTable(
              headingRowHeight: Responsive.isMobile(context) ? 36 : 48,
              dataRowHeight: Responsive.isMobile(context) ? 36 : 48,
              border: defaultTableBorder,
              headingRowColor: defaultHeaderBackground,
              columnSpacing: defaultPadding,
              showCheckboxColumn: false,
              columns: headers.map((title) => DataColumn(
                  label: Expanded(
                    child: Text(
                      title, 
                      style: TextStyle(
                        fontSize: 11,
                      )
                    )
                  )
                )
              ).toList(),
              rows: rows.map((e){
                final cells = e.map((f) => DataCell(Text(
                    f,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    )
                  ))).toList();
                return DataRow(cells: cells);
              }).toList()
            ),
          )
        )
      );
    }
    
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(defaultHalfPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row (
            children: [
              Text('Dạng'),
              SizedBox(width: defaultHalfPadding,),
              reportTimeModeDropdown(),
              SizedBox(width: defaultHalfPadding,),
              reportSheetModeDropdown(),
              SizedBox(width: defaultHalfPadding,),
              if (timeMode == ReportTimeMode.Daily)
                dateTimeButton(),
              if (timeMode == ReportTimeMode.Monthly)
                monthlyButton(),
              if (timeMode == ReportTimeMode.Yearly)
                yearlyButton(),
              
              Expanded(child: Container()),
              downloadButton(),
            ]
          ), 
          SizedBox(height: defaultPadding),
          sheet(context)
        ],
      ),
    );
  }
}