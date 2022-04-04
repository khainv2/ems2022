import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({ Key? key }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: SelectableText("Tải về"),
        onPressed: (){}
      )
    );
  }
}