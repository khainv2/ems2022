import 'dart:async';

import 'package:admin/api/alarmruleapi.dart';
import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/alarmrule.dart';
import 'package:admin/models/device.dart';
import 'package:admin/screens/alarm_rule/components/alarm_rule_editor.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class AlarmRuleScreen extends StatefulWidget {
  const AlarmRuleScreen({ Key? key }) : super(key: key);

  @override
  State<AlarmRuleScreen> createState() => _AlarmRuleScreenState();
}

class _AlarmRuleScreenState extends State<AlarmRuleScreen> {
  List<AlarmRule> alarmRules = [];
  List<int> alarmRuleSelectionIndexes = [];
  int defaultPageSize = 10;
  int currentPage = 1;
  int countPage = 1;

  void openCreateAlarmRuleDialog(){
    final onCreateRuleCallback = (rule){
      createRule(rule).then((value){
        final snackBar = SnackBar(
          content: Text(
            value ? 'Đã tạo cấu hình cảnh báo thành công!'
            : 'Tạo cấu hình cảnh báo thất bại'
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        currentPage = 1;
        getRuleListThenUpdate();
      });
    };
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: bgColor,
        content: AlarmRuleEditorWidget(
          mode: AlarmRuleEditorMode.Creator, 
          rule: AlarmRule(), 
          callback: onCreateRuleCallback
        ) 
      )
    );
  }

  void deleteAllSelectionRule(){
    

    List<String> listIDs = [];
    for (final index in alarmRuleSelectionIndexes){
      if (index >= 0 && index < alarmRules.length){
        listIDs.add(alarmRules[index].id);
      }
    }
    print(listIDs);
    removeRuleList(listIDs).then((value){
      final snackBar = SnackBar(
        content: Text(
          value ? 'Đã xóa cấu hình cảnh báo thành công!'
          : 'Thao tác thất bại'
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      currentPage = 1;
      getRuleListThenUpdate();
    });
  }

  void listenIndexChange(int index){
    if (index == alarmRuleIndex){
      getRuleListThenUpdate();
    }
  }

  void getRuleListThenUpdate(){
    getRuleList(currentPage, defaultPageSize).then((value){
      setState(() {
        alarmRules = value.rules;
        countPage = value.totalPage;
        currentPage = value.currentPage;
        alarmRuleSelectionIndexes.clear();
      });
    });
  }

  @override
  void initState(){
    super.initState();
    final userControl = UserControl();
    userControl.addStackIndexChangeListener(listenIndexChange);
    Timer(Duration(seconds: 2), (){
      listenIndexChange(alarmRuleIndex);
    });
    
  }

  @override
  void dispose(){
    super.dispose();
    final userControl = UserControl();
    userControl.removeStackIndexChangeListener(listenIndexChange);
  }

  List<Widget> createPageButton(){
    List<Widget> output = [];
    for (int i = 1; i <= countPage; i++){
      if (i == currentPage){
        final currentPageText = Container(
          child: Center(child: Text(  
            i.toString()
          ),),
          width: 40,
        );
        output.add(currentPageText);
      } else {
        if (i > 2 && i < countPage - 1 && (i - currentPage).abs() > 2){
          continue;
        }
        final btPage = ElevatedButton(
          child: Text(
            i.toString()
          ),
          onPressed: (){
            currentPage = i;
            getRuleListThenUpdate();
          },
        );
        output.add(btPage);
      }
      output.add(SizedBox(width: defaultHalfPadding));
    }
    output.add(Expanded(child: Container()));
    output.add(Text('Số trang'));
    output.add(SizedBox(width: defaultPadding));
    output.add(
      DropdownButton<int>(
        value: defaultPageSize,
        items: [10, 30, 50, 100].map((e) 
          => DropdownMenuItem<int>(
            child: Text(e.toString()), 
            value: e)
          ).toList(),
        onChanged: (val){
          if (val == null) return;
          defaultPageSize = val;
          currentPage = 1;
          getRuleListThenUpdate();
        }
      )
    );
    return output;
  }

  Widget buttonControl(){
    return Row(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)
          ),
          onPressed: openCreateAlarmRuleDialog, 
          child: Text('  Thêm  ')
        ),
        SizedBox(width: defaultPadding),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(accentColor)
          ),
          onPressed: (){
            String? warning;
            if (alarmRuleSelectionIndexes.isEmpty)
              warning = 'Cần chọn một cấu hình bất kỳ!';
            if (alarmRuleSelectionIndexes.length > 1)
              warning = 'Chỉ chọn một cấu hình duy nhất!';
            if (warning != null){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Thông báo"),
                    content: Text(warning!),
                    actions: [
                      TextButton(
                        child: Text("Đóng"),
                        onPressed:  () { Navigator.pop(context); },
                      ),
                    ],
                  );
                },
              );
              return;
            }
            final currentRule = alarmRules[alarmRuleSelectionIndexes.first];
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: bgColor,
                content: AlarmRuleEditorWidget(
                  mode: AlarmRuleEditorMode.Editor, 
                  rule: currentRule, 
                  callback: (rule){
                    updateRule(currentRule.id, rule).then((value){
                      final snackBar = SnackBar(
                        content: Text(
                          value ? 'Cập nhật cấu hình cảnh báo thành công!'
                          : 'Cập nhật cấu hình cảnh báo thất bại'
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      currentPage = 1;
                      getRuleListThenUpdate();
                    });
                  }
                ) 
              )
            );
          }, 
          child: Text('   Sửa   ')
        ),
        SizedBox(width: defaultPadding),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(alertColor)
          ),
          onPressed: (){
            if (alarmRuleSelectionIndexes.isEmpty)
              return;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Xác nhận"),
                  content: Text("Xóa toàn bộ cấu hình cảnh báo đang chọn?"),
                  actions: [
                    ElevatedButton(
                      child: Text(" Xóa "),
                      onPressed:  () { 
                        deleteAllSelectionRule();
                        Navigator.pop(context); 
                      },
                    ),
                    TextButton(
                      child: Text("Bỏ qua"),
                      onPressed:  () { Navigator.pop(context); },
                    ),
                  ],
                );
              },
            );
          }, 
          child: Text('   Xóa   ')
        ),
        Expanded(child: Container())
      ],
    );
  }

  Widget ruleTable() => Container(
    padding: EdgeInsets.all(defaultPadding),
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Danh sách cấu hình cảnh báo",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: defaultPadding,),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            primary: false,
            child: Container(
              width: double.infinity,
              child: DataTable(
                headingRowColor: defaultHeaderBackground,
                border: defaultTableBorder,
                columnSpacing: defaultPadding,
                showCheckboxColumn: false,
                columns: [
                  'Chọn', 'Tên', 'Thiết bị', 'Tham số', 'Điều kiện', 
                  'Giá trị ngưỡng', 'Mức độ', 'Kích hoạt', 'Thời điểm tạo'
                ].map((e) => DataColumn( label: Text(e, style: defaultTableHeaderStyle))).toList(), 
                rows: List.generate(
                  alarmRules.length,
                  (index){
                    final rule = alarmRules[index];
                    // String 
                    return DataRow(
                      cells: [
                        DataCell(
                          Checkbox(
                            value: alarmRuleSelectionIndexes.contains(index), 
                            onChanged: (checked){
                              if (checked == null)
                                return;
                              setState(() {
                                if (checked)
                                  alarmRuleSelectionIndexes.add(index);
                                else 
                                  alarmRuleSelectionIndexes.remove(index);
                              });
                            },
                          )
                        ),
                        DataCell(
                          Container(
                            width: 200, 
                            child: Text(rule.ruleName)
                          )
                        ),
                        DataCell(Text(Device.getNameFromSerial(rule.serial))),
                        DataCell(Text(rule.paramName)),
                        DataCell(Text(rule.condition == RuleCondition.GreaterThanOrEquals ? '>=' : '<')),
                        DataCell(Text(rule.limitValue.toString())),
                        DataCell(Text(rule.paramLevelString())),
                        DataCell(Text(rule.active? 'Bật' : 'Tắt')),
                        DataCell(Text(rule.dateString()))
                      ],
                    );
                  },
                ),
              ),
            )
          )
        ),
        SizedBox(height: defaultPadding,),
        Row(
          children: createPageButton()
        )
      ]
    )
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          buttonControl(),
          SizedBox(height: defaultPadding),
          Expanded(
            child: ruleTable()
          )
        ],
      )
    );
  }
}