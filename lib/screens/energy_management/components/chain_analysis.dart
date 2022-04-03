import 'package:admin/constants.dart';
import 'package:flutter/material.dart';



class EnergyCart extends StatelessWidget {
  const EnergyCart({
    Key? key,
    required this.title,
    required this.value,
    required this.valueColor
  }) : super(key: key);

  final String title, value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding,
        bottom: defaultPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultHalfPadding),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(width: defaultPadding),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: valueColor
            )
          )
        ],
      ),
    );
  }
}

class ChainAnalysis extends StatefulWidget {
  const ChainAnalysis({ Key? key }) : super(key: key);

  @override
  State<ChainAnalysis> createState() => _ChainAnalysisState();
}

class _ChainAnalysisState extends State<ChainAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: EnergyCart(title: "Hôm nay", value: "40.281 kWh", valueColor: primaryColor,),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Hôm qua", value: "45.283 kWh", valueColor: accentColor,),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Xu hướng", value: "-4.22 kWh", valueColor: diffColor,),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: EnergyCart(title: "Tháng này", value: "44212 kWh", valueColor: primaryColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Tháng trước", value: "38482 kWh", valueColor: accentColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Xu hướng", value: "+4828 kWh", valueColor: diffColor),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: EnergyCart(title: "Năm này", value: "442120 kWh", valueColor: primaryColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Năm trước", value: "282828 kWh", valueColor: accentColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Xu hướng", value: "+23121 kWh", valueColor: diffColor),
              ),
            ],
          ),
        ],
      )
    );
  }
}