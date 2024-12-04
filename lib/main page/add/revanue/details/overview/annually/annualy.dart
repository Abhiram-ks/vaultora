import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/overview/annually/annually_helper.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/total_sales_continer.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/totalreve_card.dart';

class Annualy extends StatelessWidget {
  const Annualy({super.key});

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
        final ValueNotifier<Map<String, dynamic>> salesYearNotifier = ValueNotifier({
      "thisYearSales": 0.0,
      "percentageChange": 0.0,
    });
     final ValueNotifier<int> yearlySalesCountNotifier = ValueNotifier(0);

      getYearlyAndPreviousComparison().then((data) {
      salesYearNotifier.value = data;
    });
        getCurrentYearSalesCount().then((count) {
      yearlySalesCountNotifier.value = count;
    });
  
    final formatter = NumberFormat("#,##0.00", "en_US");

      return Container(
        color: whiteColor,
        height: double.infinity,
        child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
                  ValueListenableBuilder<Map<String, dynamic>>(
                valueListenable: salesYearNotifier,
                builder: (context, salesData, _) {
                  final thisYearSales = salesData["thisYearSales"];
                  final percentageChange = salesData["percentageChange"];
                  final icon =
                      percentageChange >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
                  final iconColor =
                      percentageChange >= 0 ? Colors.green : Colors.red;
                  final percentageText =
                      "${percentageChange >= 0 ? '+' : ''}${percentageChange.toStringAsFixed(2)}%";
                  final formattedSales = formatter.format(thisYearSales);

                  return EarningsCard(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    title: 'Annual Earnings',
                    amount: '₹ $formattedSales',
                    icon: icon,
                    iconColor: iconColor,
                    percentageText: percentageText,
                  );
                },
              ), SizedBox(
                height: screenHeight * 0.02,
              ),
              ValueListenableBuilder<int>(
                valueListenable: yearlySalesCountNotifier,
                builder: (context, yearlySalesCount, _){
                  return BlurredBackgroundCard(
                        title: 'Sales for the Year',
                    number: yearlySalesCount.toString(),
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    );
                })
            ],
          ),
        ),
      ),
    );
  }
}