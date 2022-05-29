import 'dart:convert';

import 'package:admin/common.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/device.dart';
import 'package:http/http.dart' as http;

Future<DeviceTable> getRealtimeAllDevice() async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('GET', Uri.parse('$hostname/api/datamonitor/metersMonitor'));

  request.headers.addAll(headers);
  
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();
    Map<String, Device> acbList = {};
    Map<String, Device> multimeterList = {};
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
      Map<String, DeviceParam> outparamlist = {};
      for (final param in rt_dataParam){
        final pname = param['pname'];
        final punit = param['punit'];
        final pvalue = param['pvalue'];
        final outparam = DeviceParam(pname, pvalue, punit);
        outparamlist[pname] = outparam;
      }

      if (mtserial.startsWith('ACB')){
        final device = Device(
          type: DeviceType.ACB,
          name: mtname,
          address: mtcfg_addr,
          state: DeviceState.values[rt_status],
          realtimeParam: outparamlist
        );
        acbList[mtname] = device;
      } else {
        final device = Device(
          type: DeviceType.Multimeter,
          name: mtname,
          address: mtcfg_addr,
          state: DeviceState.values[rt_status],
          realtimeParam: outparamlist
        );
        multimeterList[mtname] = device;
      }
      
    }
    print('Realtime result ${acbList.length}, ${multimeterList.length}');
    return DeviceTable(acbList, multimeterList);
  } else {
    print(response.reasonPhrase);
    return DeviceTable({}, {});
  }
}


Future<Device?> getRealtime(String serial) async {
  final userControl = UserControl();
  var headers = {
    'Authorization': 'Bearer ${userControl.token}'
  };
  var request = http.Request('GET', Uri.parse('$hostname/api/datamonitor/meterMonitor/$serial'));

  request.headers.addAll(headers);
  
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final ret = await response.stream.bytesToString();

    final totalMessage = json.decode(ret);
    final data = totalMessage['data'];
    final mtserial = data['mtserial'];
    final mtname = data['mtname'];
    final mtinfo = data['mtinfo'];
    final mtloc_lat = data['mtloc_lat'];
    final mtloc_long = data['mtloc_long'];
    final mtcfg_addr = data['mtcfg_addr'];
    final mtcfg_model = data['mtcfg_model'];
    final mtcfg_datainterval = data['mtcfg_datainterval'];
    final mtalarm_active = data['mtalarm_active'];
    final gwserial = data['gwserial'];
    final rt_status = data['rt_status'];
    final rt_dataTime = data['rt_dataTime'];
    final rt_dataParam = data['rt_dataParam'];
    Map<String, DeviceParam> outparamlist = {};
    for (final param in rt_dataParam){
      final pname = param['pname'];
      final punit = param['punit'];
      final pvalue = param['pvalue'];
      final outparam = DeviceParam(pname, pvalue, punit);
      outparamlist[pname] = outparam;
    }

    return Device(
      type: mtserial.startsWith('ACB') ? DeviceType.ACB : DeviceType.Multimeter,
      name: mtname,
      address: mtcfg_addr,
      state: DeviceState.values[rt_status],
      realtimeParam: outparamlist
    );
    
  } else {
    print(response.reasonPhrase);
    return null;
  }
}