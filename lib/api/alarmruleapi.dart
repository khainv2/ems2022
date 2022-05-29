import 'package:admin/common.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/alarmrule.dart';

class RuleListResult {
  bool ok = false;
  List<AlarmRule> rules = [];
  int currentPage = 1;
  int totalPage = 1;
  int total = 1;
  int pageSize = 1;
}

Future<bool> updateRule(String id, AlarmRule rule) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('PUT', Uri.parse('$hostname/api/alarmrule/act/$id'));
  request.body = json.encode({
    "mtserial": rule.serial,
    "rulename": rule.ruleName,
    "condid": rule.condition == RuleCondition.GreaterThanOrEquals ? 1 : 2,
    "paramname": rule.paramName,
    "limitvalue": rule.limitValue,
    "alarmdelay": rule.paramDelay,
    "alarmlevel": rule.paramLevel,
    "active": rule.active
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
  } else {
    print(response.reasonPhrase);
    return false;
  }

}

Future<bool> removeRule(String id) async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('DELETE', Uri.parse('$hostname/api/alarmrule/act/$id'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
  } else {
    print(response.reasonPhrase);
    return false;
  }
}

Future<bool> removeRuleList(List<String> listIDs) async {
  bool deleteSuccess = false;
  for (final id in listIDs){
    bool ret = await removeRule(id);
    if (ret){
      deleteSuccess = true;
    }
  }
  return deleteSuccess;
}

Future<bool> createRule(AlarmRule rule) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('POST', Uri.parse('$hostname/api/alarmrule/act'));
  request.body = json.encode({
    "mtserial": rule.serial,
    "rulename": rule.ruleName,
    "condid": rule.condition == RuleCondition.GreaterThanOrEquals ? 1 : 2,
    "paramname": rule.paramName,
    "limitvalue": rule.limitValue,
    "alarmdelay": rule.paramDelay,
    "alarmlevel": rule.paramLevel,
    "active": rule.active
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
  } else {
    print(response.reasonPhrase);
    return false;
  }
}

Future<RuleListResult> getRuleList(int pageIndex, int pageSize) async {
  final userControl = UserControl();
  var headers = { 'Authorization': 'Bearer ${userControl.token}' };
  String url = '$hostname/api/alarmrule/list';
  if (pageSize > 0){
    url += '/p/$pageIndex/s/$pageSize';
  }
  var request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);
  print('start get alarm rule');

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    final ruleListResult = RuleListResult();

    ruleListResult.ok = true;
    final data = json.decode(ret);
    final d = data['data'];
    final pagination = d["pagination"];
    ruleListResult.currentPage = pagination["current"];
    ruleListResult.totalPage = pagination["totalPage"];
    ruleListResult.total = pagination["total"];
    ruleListResult.pageSize = pagination["pageSize"];
    final list = d['list'];
    for (final item in list){
      final rule = AlarmRule(
        id: item['id'],
        serial: item['mtserial'],
        ruleName: item['rulename'],
        condition: item['condid'] == 1 
          ? RuleCondition.GreaterThanOrEquals : RuleCondition.LessThan,
        paramName: item['paramname'],
        limitValue: item['limitvalue'],
        paramDelay: item['alarmdelay'],
        paramLevel: item['alarmlevel'],
        active: item['active'],
        timeCreated: item['createdTime']
      );
      ruleListResult.rules.add(rule);
    }
    return ruleListResult;
  }
  else {
    print(response.reasonPhrase);
    return RuleListResult()
      ..ok = false;
  }
}