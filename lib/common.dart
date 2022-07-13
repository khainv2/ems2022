import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Khai báo toàn bộ màu sắc
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color.fromARGB(255, 39, 43, 63);
const accentColor = Color(0xFFff8f26);
const bgColor = Color(0xFF212332);
const diffColor = Color(0xffc2c2c2);
const alertColor = Color(0xffcc0000);
const borderColor = Colors.white12;

// Khai báo các khoảng cách (dimension)
const defaultPadding = 16.0;
const defaultHalfPadding = 8.0;
// Tên server kết nối
const hostname = 'http://14.177.235.18:8082';

final fullDateFormatter = DateFormat('dd/MM/yyyy');

const defaultBorderSide = BorderSide(
  color: borderColor,
  width: 1,
);
const defaultTableBorder = TableBorder(
  top: defaultBorderSide,
  bottom: defaultBorderSide,
  left: defaultBorderSide,
  right: defaultBorderSide,
  verticalInside: defaultBorderSide,
);

const defaultTableHeaderStyle = TextStyle(
  fontWeight: FontWeight.bold,
);

final defaultHeaderBackground = MaterialStateColor.resolveWith((states) => primaryColor.withAlpha(80));

enum ReportTimeMode {
  Daily, Monthly, Yearly
}

enum ReportSheetMode {
  Input, Load
}