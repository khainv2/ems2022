import 'package:admin/api/energy_trend.dart';
import 'package:admin/common.dart';
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
  
  final EnergyTrendTotal energyTrendTotal;
  const ChainAnalysis({ Key? key, required this.energyTrendTotal }) : super(key: key);

  @override
  State<ChainAnalysis> createState() => _ChainAnalysisState();
}

class _ChainAnalysisState extends State<ChainAnalysis> {
  @override
  Widget build(BuildContext context) {
    double dBefore = 0;
    double dCurrent = 0;
    double dTrend = 0;
    double mBefore = 0;
    double mCurrent = 0;
    double mTrend = 0;
    double yBefore = 0;
    double yCurrent = 0;
    double yTrend = 0;

    if (widget.energyTrendTotal.success && widget.energyTrendTotal.day != null && widget.energyTrendTotal.day!.success){
      dCurrent = widget.energyTrendTotal.day!.sumCurrent;
      dBefore = widget.energyTrendTotal.day!.sumBefore;
      dTrend = widget.energyTrendTotal.day!.sumTrend;
      mCurrent = widget.energyTrendTotal.month!.sumCurrent;
      mBefore = widget.energyTrendTotal.month!.sumBefore;
      mTrend = widget.energyTrendTotal.month!.sumTrend;
      yCurrent = widget.energyTrendTotal.year!.sumCurrent;
      yBefore = widget.energyTrendTotal.year!.sumBefore;
      yTrend = widget.energyTrendTotal.year!.sumTrend;
      
    }

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
                child: EnergyCart(title: "Hôm nay", value: "${(dCurrent / 1000).toStringAsFixed(2)} kWh", valueColor: primaryColor,),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Hôm qua", value: "${(dBefore / 1000).toStringAsFixed(2)} kWh", valueColor: accentColor,),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Xu hướng", value: "${(dTrend / 1000).toStringAsFixed(2)} kWh", valueColor: diffColor,),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: EnergyCart(title: "Tháng này", value: "${(mCurrent / 1000).toStringAsFixed(2)} kWh", valueColor: primaryColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Tháng trước", value: "${(mBefore / 1000).toStringAsFixed(2)} kWh", valueColor: accentColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Xu hướng", value: "${(mTrend / 1000).toStringAsFixed(2)} kWh", valueColor: diffColor),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: EnergyCart(title: "Năm này", value: "${(yCurrent / 1000).toStringAsFixed(2)} kWh", valueColor: primaryColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Năm trước", value: "${(yBefore / 1000).toStringAsFixed(2)} kWh", valueColor: accentColor),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: EnergyCart(title: "Xu hướng", value: "${(yTrend / 1000).toStringAsFixed(2)} kWh", valueColor: diffColor),
              ),
            ],
          ),
        ],
      )
    );
  }
}