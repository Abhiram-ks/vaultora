import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/overview/mothly/mothly_helper.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/total_sales_continer.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/totalreve_card.dart';
import '../../../../../../db/functions/salefuction.dart';
import '../../../../../../db/models/sales/onsale.dart';
import '../../../chart_color.dart';
import '../../../revanue_sub/line_chart.dart';
import '../../reve_sub_class/pie_chart.dart';

class PerMonth extends StatelessWidget {
  const PerMonth({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final ValueNotifier<Map<String, dynamic>> salesMonthNotifier =
        ValueNotifier({"thisMonthSales": 0.0, "percentageChange": 0.0});
    final ValueNotifier<int> monthlySalesCountNotifier = ValueNotifier(0);

    getMonthlyAndPreviousComparison().then((data) {
      salesMonthNotifier.value = data;
    });
    getCurrentMonthSalesCount().then((count) {
      monthlySalesCountNotifier.value = count;
    });
    final formatter = NumberFormat("#,##0.00", "en_US");

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ValueListenableBuilder<Map<String, dynamic>>(
                valueListenable: salesMonthNotifier,
                builder: (context, salesData, _) {
                  final thisMonthSales = salesData["thisMonthSales"];
                  final percentageChange = salesData["percentageChange"];
                  final icon = percentageChange >= 0
                      ? Icons.arrow_upward
                      : Icons.arrow_downward;
                  final iconColor =
                      percentageChange >= 0 ? Colors.green : Colors.red;
                  final percentageText =
                      "${percentageChange >= 0 ? '+' : ''}${percentageChange.toStringAsFixed(2)}%";
                  final formattedSales = formatter.format(thisMonthSales);

                  return EarningsCard(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    title: 'Periodic Revenue',
                    amount: '₹ $formattedSales',
                    icon: icon,
                    iconColor: iconColor,
                    percentageText: percentageText,
                  );
                }),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              height: screenHeight * 0.65,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder<int>(
                        valueListenable: monthlySalesCountNotifier,
                        builder: (context, monthlySalesCount, _) {
                          return BlurredBackgroundCard(
                            title: 'Sales for the Month',
                            number: monthlySalesCount.toString(),
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          );
                        }), SizedBox(
              height: screenHeight * 0.02,
            ),
            ValueListenableBuilder<List<SalesModel>>(
              valueListenable: salesListNotifier,
              builder: (context, salesList, _) {
                if (salesList.isEmpty) {
                  return const Center(
                    child: Text('No sales data available for Month'),
                  );
                }
                return FutureBuilder<Map<String, dynamic>>(
                  future: getTopSoldProductsForMonth(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData ||
                        snapshot.data!['message'] != null) {
                      return const Center(
                          child: Text('No product sales data available'));
                    }

                    final productData = snapshot.data!;
                    return PieChartWidget(
                      screenHeight: MediaQuery.of(context).size.height,
                      screenWidth: MediaQuery.of(context).size.width,
                      segmentColors: GlobalColors.segmentColors,
                      segmentValues: productData['segmentValues'],
                      segmentLabels: productData['segmentLabels'],
                      sublabel: productData['subLabels'],
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ValueListenableBuilder<List<SalesModel>>(
              valueListenable: salesListNotifier,
              builder: (context, salesList, _) {
                  if (salesList.isEmpty) {
                  return const Center(
                    child: Text('No sales data available for Month'),
                  );
                }
                return FutureBuilder<Map<String, dynamic>>(
                  future: getSalesDataForChartMonth(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!['months'].isEmpty) {
                      return const Center(
                        child: Text('No sales data available for the chart.'),
                      );
                    }

                    final months = snapshot.data!['months'];
                    final values = snapshot.data!['values'];
                    final maxY = snapshot.data!['maxY'] ?? 200.0;
                    final minY = snapshot.data!['minY'] ?? 0.0;

                    return CustomLineChart(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      months: months.cast<String>(),
                      values: values.cast<double>(),
                      maxY: maxY,
                      minY: minY,
                    );
                  },
                );
              },
            ),
                  ],
                ),
              ),
            ),
           
            SizedBox(
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
