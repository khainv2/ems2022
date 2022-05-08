import 'package:admin/constants.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:http/http.dart' as http;

Future<List<Device>> getRealtime() async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('GET', Uri.parse('$hostname/api/datamonitor/metersMonitor'));

  request.headers.addAll(headers);
  
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    print(ret);
    // Map<String, String> output = {};
    // final paramlist = json.decode(ret)['data']['rt_dataParam'];
    // for (final param in paramlist){
    //   final name = param['pname'];
    //   final punit = param['punit'];
    //   final pval = param['pvalue'];
    //   output[name] = '$pval $punit';
    // }
    return [];
  } else {
    print(response.reasonPhrase);
    return [];
  }
}