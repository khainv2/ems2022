import 'dart:convert';

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
    List<Device> output = [];
    final totalMessage = json.decode(ret);
    final data = totalMessage['data'];
    final meters = data['meters'];
    for (final meter in meters){
      final mtserial = meter['mtserial'];
      final mtname = meter['mtname'];
      final mtinfo = meter['mtinfo'];
      final mtloc_lat = meter['mtloc_lat'];
      final mtloc_long = meter['mtloc_long'];
      final mtcfg_addr = meter['mtcfg_addr'];
      final mtcfg_model = meter['mtcfg_model'];
      final mtcfg_datainterval = meter['mtcfg_datainterval'];
      final mtalarm_active = meter['mtalarm_active'];
      final gwserial = meter['gwserial'];
      final rt_status = meter['rt_status'];
      final rt_dataTime = meter['rt_dataTime'];
      final rt_dataParam = meter['rt_dataParam'];
      List<DeviceParam> outparamlist = [];
      for (final param in rt_dataParam){
        final pname = param['pname'];
        final punit = param['punit'];
        final pvalue = param['pvalue'];
        final outparam = DeviceParam(pname, pvalue, punit);
        outparamlist.add(outparam);
      }
      
      final device = Device(
        id: 0,
        name: mtname,
        
      );
    }

    return output;

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