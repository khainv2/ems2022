import 'package:admin/controllers/user_control.dart';
import 'dart:convert';
import 'package:admin/controllers/user_control.dart';
import 'package:admin/models/define.dart';
import 'package:admin/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:admin/controllers/user_control.dart';

Future<Map<String, String>> getRealtime() async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('GET', Uri.parse('$hostname/api/datamonitor/meterRealtimeData/MM01'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    Map<String, String> output = {};
    final paramlist = json.decode(ret)['data']['rt_dataParam'];
    for (final param in paramlist){
      final name = param['pname'];
      final punit = param['punit'];
      final pval = param['pvalue'];
      output[name] = '$pval $punit';
    }
    return output;
  } else {
    print(response.reasonPhrase);
    return {};
  }
}