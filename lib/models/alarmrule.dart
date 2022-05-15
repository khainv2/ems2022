
import 'package:intl/intl.dart';

enum RuleCondition { LessThan, GreaterThanOrEquals }
class AlarmRule {
  String id;
  String serial;
  String ruleName;
  RuleCondition condition;
  String paramName;
  double limitValue;
  int paramDelay;
  int paramLevel;
  bool active;
  int timeCreated;
  AlarmRule({
    this.id = '',
    this.serial = "",
    this.ruleName = "",
    this.condition = RuleCondition.LessThan,
    this.paramName = "",
    this.limitValue = 0,
    this.paramDelay = 0,
    this.paramLevel = 0,
    this.active = false,
    this.timeCreated = 0
  });

  String conditionStr(){
    return (condition == RuleCondition.GreaterThanOrEquals ? 1 : 2).toString();
  }

  String paramLevelString(){
    switch (paramLevel){
      case 1: return 'Cao';
      case 2: return 'Vừa';
      case 3: return 'Thấp';
      default: return '';
    }
  }

  String dateString(){
    final dateFormatter = DateFormat('dd/MM/yyyy hh:mm:ss');
    final time = DateTime.fromMillisecondsSinceEpoch(timeCreated * 1000);
    return dateFormatter.format(time);
  }
}
