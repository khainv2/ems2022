import 'package:admin/models/sampleVal.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

import 'dart:html' as html;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void downloadFile(String url) {
   html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
   anchorElement.download = url;
   anchorElement.click();
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('text/file.txt');
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({ Key? key }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}
// https://firebasestorage.googleapis.com/v0/b/ewew-bc020.appspot.com/o/DIEN%20NANG%20TIEU%20THU%20TRAM%20BOM%20XXX_01102018.xlsx?alt=media&token=7c168405-7f5f-45fd-b9ae-8d3813b2dddc
class _ReportScreenState extends State<ReportScreen> {
  String link = "https://firebasestorage.googleapis.com/v0/b/ewew-bc020.appspot.com/o/DIEN%20NANG%20TIEU%20THU%20TRAM%20BOM%20XXX_01102018.xlsx?alt=media&token=7c168405-7f5f-45fd-b9ae-8d3813b2dddc";
  final column = "Ngày	HP1	HP2	NĂNG LƯỢNG ĐẦU VAO	NĂNG LƯỢNG TIÊU THỤ	NĂNG LƯỢNG TỔN HAO".split('\t');
  String? textData;
  
  @override 
  void initState(){
    super.initState();
    loadAsset().then((value){
      setState(() {
        textData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Column length ${column.length}");
    List<List<String>> rows = [];
    if (textData != null){
      final lines = textData!.split('\n');
      for (final line in lines){
        final words = line.split('\t');
        print("Row length ${words.length}");
        if (words.length == column.length)
          rows.add(words);
      }
    }


    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Báo cáo",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          
          Container(
            width: 300,
            child: OutlinedButton(
                
              child: Row(
                children: [
                  Icon(Icons.calendar_month),
                  Text("20/03/2022")
                ],
              ),
              onPressed: (){
                showDatePicker(context: context, 
                              initialDate: DateTime.now(), 
                              firstDate: DateTime(2015, 8), 
                              lastDate: DateTime(2101));
              },
            ),
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: (){
              downloadFile(link);
            }, 
            child: Text('Tải về')
          ),
          SizedBox(height: defaultPadding),


          Expanded(
            // child: Scrollbar(
            //   isAlwaysShown: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                
                child: Container(
                  width: double.infinity,
                  child: DataTable(
                  columnSpacing: 0,
                  showCheckboxColumn: false,
                  columns: column.map((e) => DataColumn(label: Text(e))).toList(),
                  rows: List.generate(
                    rows.length,
                    (index){
                      final row = rows[index];
                      return DataRow(
                        cells: row.map((e) => DataCell(Text(e))).toList()
                      );
                    },
                  ),
                ),
                )
              // )
            )
            
          ),
        ],
      ),
    );
  }
}