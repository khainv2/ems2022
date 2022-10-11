import 'package:admin/api/history.dart';
import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'dart:convert';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/log.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum EnergyTrendMode {
  Day,
  Month, 
  Year
}

int energyModeToVal(EnergyTrendMode mode){
  if (mode == EnergyTrendMode.Day) return 2;
  else if (mode == EnergyTrendMode.Month) return 3;
  else return 4;
}

DateFormat dateFormatByMode(EnergyTrendMode mode){
  switch (mode){
    case EnergyTrendMode.Day: return DateFormat('yyyy-MM-dd');
    case EnergyTrendMode.Month: return DateFormat('yyyy-MM');
    default: return DateFormat('yyyy');
  }
}

class EnergyTrendTotal {
  bool success = false;
  EnergyTrendHistory? day;
  EnergyTrendHistory? month;
  EnergyTrendHistory? year;
  
  EnergyTrendTotal({
    required this.success
  });
}

class TrendParam {
  int time;
  double value;
  TrendParam(this.time, this.value);
}

class TrendDualParam {
  int time;
  double beforeValue, currentValue;
  TrendDualParam(this.time, this.beforeValue, this.currentValue);
}

class EnergyTrendHistory {
  bool success = false;
  List<TrendParam> beforeList = [];
  List<TrendParam> currentList = [];
  double sumBefore = 0;
  double sumCurrent = 0;
  double sumTrend = 0;

  List<TrendDualParam> getListDual(){
    Map<int, TrendDualParam> map = {};
    for (final p in beforeList){
      if (!map.containsKey(p.time))
        map[p.time] = TrendDualParam(p.time, 0, 0);
      map[p.time]!.beforeValue = p.value;
    }
    for (final p in currentList){
      if (!map.containsKey(p.time))
        map[p.time] = TrendDualParam(p.time, 0, 0);
      map[p.time]!.currentValue = p.value;
    }
    final list = map.values.toList();
    list.sort((a, b) => a.time.compareTo(b.time));
    return list.toList();  
  }
}

Future<EnergyTrendTotal> getEnergyTrendTotal(String serial, DateTime today) async {
  final day = await getEnergyTrend(serial, EnergyTrendMode.Day, today);
  final month = await getEnergyTrend(serial, EnergyTrendMode.Month, today);
  final year = await getEnergyTrend(serial, EnergyTrendMode.Year, today);
  
  return EnergyTrendTotal(
    success: day.success && month.success && year.success
  )
  ..day = day
  ..month = month
  ..year = year
  ;
}

Future<EnergyTrendHistory> getEnergyTrend(String serial, EnergyTrendMode mode, DateTime dateTime) async {
  final userControl = UserControl();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('POST', Uri.parse('$hostname/api/energy/energy_trend'));
  
  request.body = json.encode({
    "mtserial": serial,
    "trendtype": energyModeToVal(mode),
    "timestr": dateFormatByMode(mode).format(dateTime)
  });
  request.headers.addAll(headers);
  print(headers);
  print(request.body);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    final retJson = jsonDecode(ret);
    final beforeList = retJson['data']['beforeList'];
    final currentList = retJson['data']['currentList'];

    List<TrendParam> beforeParams = [];
    for (final e in beforeList){
      int time;
      if (mode == EnergyTrendMode.Day){
        final t = e['time'].split(':');
        final hour = t[0];
        // final minute = t[1];
        time = int.tryParse(hour) ?? 0;
      } else {
        time = int.tryParse(e['time']) ?? 0;
      }
      beforeParams.add(TrendParam(time, e['value']));
    }
    List<TrendParam> currentParams = [];
    for (final e in currentList){
      int time;
      if (mode == EnergyTrendMode.Day){
        final t = e['time'].split(':');
        final hour = t[0];
        // final minute = t[1];
        time = int.tryParse(hour) ?? 0;
      } else {
        time = int.tryParse(e['time']) ?? 0;
      }
      currentParams.add(TrendParam(time, e['value']));
    }
    final sum = retJson['data']['trend'];
    double sumBefore = sum['before'];
    double sumCurrent = sum['current'];
    double sumTrend = sum['trend'];
    return EnergyTrendHistory()
    ..success = true
    ..beforeList = beforeParams
    ..currentList = currentParams
    ..sumBefore = sumBefore
    ..sumCurrent = sumCurrent
    ..sumTrend = sumTrend;
  } else {
    print(response.reasonPhrase);
    return EnergyTrendHistory();
  }
}

