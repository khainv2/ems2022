import 'package:admin/models/msb.dart';
import 'package:admin/models/msblistsample.dart';
import 'package:admin/models/sampleVal.dart';
import 'package:admin/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../common.dart';

class MsbList extends StatelessWidget {
  final Function(int) requestChangeCurrentMsb;
  final int currentMsbIndex;
  const MsbList({
    Key? key,
    required this.requestChangeCurrentMsb,
    required this.currentMsbIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultHalfPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tủ điện",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox( height: defaultHalfPadding ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowColor: defaultHeaderBackground,
              headingRowHeight: Responsive.isMobile(context) ? 36 : 48,
              dataRowHeight: Responsive.isMobile(context) ? 36 : 48,
              border: defaultTableBorder,
              columnSpacing: defaultPadding,
              showCheckboxColumn: false,
              columns: [
                DataColumn(
                  label: Text("Tên"),
                ),
                DataColumn(
                  label: Text("Thiết bị"),
                ),
              ],
              rows: List.generate(
                listMsbSample.length,
                (index) => recentFileDataRow(listMsbSample[index], index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow recentFileDataRow(Msb msb, int index) {
    final selected = index == currentMsbIndex;
    Color titleColor = selected ? accentColor : Colors.white;
    final backgroundColor = selected ? bgColor : secondaryColor;
    return DataRow(
      onSelectChanged: (selected) => {
        requestChangeCurrentMsb(index)
      },
      color: MaterialStateColor.resolveWith((states) => 
        backgroundColor
      ),
      cells: [
        DataCell(
          Text(msb.title!, style: TextStyle(color: titleColor),),
        ),
        DataCell(Text((msb.deviceList ?? []).length.toString(), style: TextStyle(color: titleColor),)),
      ],
    );
  }
}
