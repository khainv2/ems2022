

import 'package:admin/common.dart';
import 'package:admin/models/alarmrule.dart';
import 'package:admin/models/device.dart';
import 'package:admin/models/msblistsample.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final double titleAlarmRuleWidth = 130;
final double contentAlarmRuleWidth = 240;
enum AlarmRuleEditorMode {
  Creator, 
  Editor
}

class AlarmRuleEditorWidget extends StatefulWidget {
  final AlarmRuleEditorMode mode;
  final AlarmRule rule;
  final Function(AlarmRule) callback;
  AlarmRuleEditorWidget({ Key? key,
   required this.mode, required this.rule, required this.callback }) : super(key: key);

  @override
  State<AlarmRuleEditorWidget> createState() => _AlarmRuleEditorWidgetState();
}

class _AlarmRuleEditorWidgetState extends State<AlarmRuleEditorWidget> {
  
  final _nameControl = TextEditingController();
  bool _nameValid = true;
  String _serial = '';
  String _param = "U1";
  RuleCondition _condition = RuleCondition.LessThan;
  final _valueControl = TextEditingController();
  bool _valueValid = true;
  final _delayControl = TextEditingController();
  bool _delayValid = true;
  int _level = 1;
  bool _active = true;

  @override 
  void initState(){
    super.initState();
    if (widget.mode == AlarmRuleEditorMode.Creator){
      _valueControl.text = '0';
      _delayControl.text = '0';
    } else {
      _valueControl.text = widget.rule.limitValue.toString();
      _delayControl.text = widget.rule.paramDelay.toString();
      _nameControl.text = widget.rule.ruleName;
      _serial = widget.rule.serial;
      _condition = widget.rule.condition;
      _param = widget.rule.paramName;
      _level = widget.rule.paramLevel;
      _active = widget.rule.active;
    }
  }

  Widget deviceSelection(){
    final multimeters = getDeviceListByType(DeviceType.Multimeter);
    final acbs = getDeviceListByType(DeviceType.ACB);

    List<DropdownMenuItem<String>> items = [];
    items.addAll(
      multimeters.map((e) => DropdownMenuItem(
        child: Text(e.name),
        value: e.getSerial()
      ))
    );
    items.addAll(
      acbs.map((e) => DropdownMenuItem(
        child: Text(e.name),
        value: e.getSerial()
      ))
    );
    if (_serial.isEmpty && items.isNotEmpty){
      _serial = multimeters.first.getSerial();
    }
    return Row (
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('Ch???n thi???t b???')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
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
              child: DropdownButton<String>(
                elevation: 62,
                style: const TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                value: _serial,
                items: items,
                onChanged: (val){
                  setState(() {
                    if (val == null) 
                      return;
                    // Reset gi?? tr??? param hi???n t???i n???u c???n
                    final type = Device.getTypeFromSerial(val);
                    final lastType = Device.getTypeFromSerial(_serial);
                    if (type != lastType){
                      _param = 'U1';
                    }
                    _serial = val;
                  });
                },
              )
            ),
          ),
        )
      ],
    );
  }

  Widget ruleName(){
    return Row(
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('T??n c???u h??nh')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
          child: TextField(
            controller: _nameControl,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              errorText: _nameValid ? null : 'T??n kh??ng ???????c ????? tr???ng'
            ),
          ),
        ),
      ],
    );
  }

  Widget paramSelection(){
    final type = Device.getTypeFromSerial(_serial);
    final paramList = type == DeviceType.ACB ? acbParamList : multimeterParamList;
    final items = paramList.map(
      (t) => DropdownMenuItem<String>(
        child: Text(t), 
        value: t
      )
    ).toList();
    return Row (
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('Tham s???')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
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
              child: DropdownButton<String>(
                elevation: 62,
                style: const TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                value: _param,
                items: items,
                onChanged: (val){
                  setState(() {
                    if (val != null) _param = val;
                  });
                },
              )
            ),
          ),
        )
      ],
    );
  }

  Widget conditionSelection(){
    return Row (
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('??i???u ki???n so s??nh')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
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
              child: DropdownButton<RuleCondition>(
                elevation: 62,
                style: const TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                value: _condition,
                items: [
                  DropdownMenuItem<RuleCondition>(
                    child: Text('<'),
                    value: RuleCondition.LessThan
                  ),
                  DropdownMenuItem<RuleCondition>(
                    child: Text('>='),
                    value: RuleCondition.GreaterThanOrEquals
                  ),
                ],
                onChanged: (val){
                  setState(() {
                    if (val != null) _condition = val;
                  });
                },
              )
            ),
          ),
        )
      ],
    );
  }

  Widget ruleValue(){
    return Row(
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('Gi?? tr??? ng?????ng')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
          child: TextFormField(
            controller: _valueControl,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              errorText: _valueValid ? null : 'Gi?? tr??? ng?????ng kh??ng h???p l???'
            ),
          ),
        ),
      ],
    );
  }

  Widget delayValue(){
    return Row(
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('????? tr??? [s]')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
          child: TextFormField(
            controller: _delayControl,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              errorText: _delayValid ? null : 'Gi?? tr??? ????? tr??? kh??ng h???p l???'
            ),
          ),
        ),
      ],
    );
  }

  Widget level(){
    return Row (
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('M???c ?????')),
        SizedBox(width: defaultPadding,),
        Container(
          width: contentAlarmRuleWidth,
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
                value: _level,
                items: [1, 2, 3].map((e) => 
                  DropdownMenuItem<int>(
                    child: Text(AlarmRule(paramLevel: e).paramLevelString()),
                    value: e
                  )
                ).toList(),
                onChanged: (val){
                  setState(() {
                    if (val != null) _level = val;
                  });
                },
              )
            ),
          ),
        )
      ],
    );
  }

  Widget active(){
    return Row (
      children: [
        SizedBox( width: titleAlarmRuleWidth, child: Text('K??ch ho???t')),
        SizedBox(width: defaultPadding,),
        SizedBox(
          width: 120,
          child: ListTile(
            title: const Text('T???t'),
            leading: Radio<bool>(
              value: false,
              groupValue: _active,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null)
                    _active = value;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: ListTile(
            title: const Text('B???t'),
            leading: Radio<bool>(
              value: true,
              groupValue: _active,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null)
                    _active = value;
                });
              },
            ),
          ),
        )
      ]
    );
    
  }

  // N??t th??m, s???a ho???c h???y dialog
  Widget buttonPanel(){
    return Row(
      children: [
        Expanded(child: Container()),
        ElevatedButton(
          child: Text(
            widget.mode == AlarmRuleEditorMode.Creator ? "  Th??m  " : "C???p nh???t"
          ),
          onPressed: () {
            _nameValid = _nameControl.text.isNotEmpty;
            final limitVal = double.tryParse(_valueControl.text);
            _valueValid = (limitVal != null);
            final delayVal = int.tryParse(_delayControl.text);
            _delayValid = (delayVal != null);
            if (!_nameValid || !_valueValid || !_delayValid){
              setState(() {});
              return;
            }
            final rule = AlarmRule(
              serial: _serial,
              ruleName: _nameControl.text,
              condition: _condition,
              paramName: _param,
              limitValue: limitVal!,
              paramDelay: delayVal!,
              paramLevel: _level,
              active: _active,
            );
            widget.callback(rule);
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: defaultHalfPadding),
        TextButton(
          child: Text("   H???y   "),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.mode == AlarmRuleEditorMode.Creator 
              ? "Th??m c???u h??nh c???nh b??o" : "S???a c???u h??nh c???nh b??o",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: defaultPadding * 2),
          ruleName(),
          SizedBox(height: defaultHalfPadding),
          deviceSelection(),
          SizedBox(height: defaultHalfPadding),
          paramSelection(),
          SizedBox(height: defaultHalfPadding),
          conditionSelection(),
          SizedBox(height: defaultHalfPadding),
          ruleValue(),
          SizedBox(height: defaultHalfPadding),
          delayValue(),
          SizedBox(height: defaultHalfPadding),
          level(),
          SizedBox(height: defaultHalfPadding),
          active(),
          SizedBox(height: defaultHalfPadding),
          buttonPanel()
        ],
      ),
    );
  }
}
