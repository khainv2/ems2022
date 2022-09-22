import 'package:admin/api/energy_trend.dart';
import 'package:admin/common.dart';
import 'package:flutter/material.dart';


class DayInfoCart extends StatelessWidget {
  const DayInfoCart({
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(child: Container()),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: valueColor
            )
          )
        ],
      ),
    );
  }
}

class PeakConsumption extends StatelessWidget {
  final EnergyTrendTotal energyTrendTotal;
  const PeakConsumption({ Key? key, required this.energyTrendTotal }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double today = 0;
    double yesterday = 0;
    if (energyTrendTotal.success && energyTrendTotal.day != null && energyTrendTotal.day!.success){
      today = energyTrendTotal.day!.sumCurrent;
      yesterday = energyTrendTotal.day!.sumBefore;
    }
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: DayInfoCart(title: "Hôm qua", value: "${yesterday}W", valueColor: accentColor,),
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: DayInfoCart(title: "Hôm nay", value: "${today}W", valueColor: primaryColor,),
          )
          
        ],
      )
    );
  }
}
