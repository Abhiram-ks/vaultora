
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/chart_color.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/overview/perdays/day_helper.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/pie_chart.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/total_sales_continer.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/totalreve_card.dart';

import '../../../revanue_sub/line_chart.dart';

class DayWise extends StatelessWidget {
  const DayWise({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final ValueNotifier<Map<String, dynamic>> salesDataNotifier =
        ValueNotifier({"todaySales": 0.0, "percentageChange": 0.0});
    final ValueNotifier<int> todaySalesCountNotifier = ValueNotifier(0);

    getTodayAndPreviousComparison().then((date) {
      salesDataNotifier.value = date;
    });

    getTodaySalesCount().then((count) {
      todaySalesCountNotifier.value = count;
    });
    final formatter = NumberFormat("#,##0.00", "en_US");

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ValueListenableBuilder<Map<String, dynamic>>(
              valueListenable: salesDataNotifier,
              builder: (context, salesData, _) {
                final todaySales = salesData["todaySales"];
                final percentageChange = salesData["percentageChange"];
                final icon = percentageChange >= 0
                    ? Icons.arrow_upward
                    : Icons.arrow_downward;
                final iconColor =
                    percentageChange >= 0 ? Colors.green : Colors.red;
                final percentageText =
                    "${percentageChange >= 0 ? '+' : ''}${percentageChange.toStringAsFixed(2)}%";
                final formattedSales = formatter.format(todaySales);
                return EarningsCard(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  title: 'Sales Report',
                  amount: '₹ $formattedSales',
                  icon: icon,
                  iconColor: iconColor,
                  percentageText: percentageText,
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              height: screenHeight * 0.65,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder<int>(
                        valueListenable: todaySalesCountNotifier,
                        builder: (context, todaySalesCount, _) {
                          return BlurredBackgroundCard(
                              title: 'Sales of the Day',
                              number: todaySalesCount.toString(),
                              screenHeight: screenHeight,
                              screenWidth: screenWidth);
                        }),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    ValueListenableBuilder<List<SalesModel>>(
                      valueListenable: salesListNotifier,
                      builder: (context, salesList, _) {
                        if (salesList.isEmpty) {
                          return const Center(
                            child: Text('No sales data available for today'),
                          );
                        }

                        return FutureBuilder<Map<String, dynamic>>(
                          future: getTopSoldProducts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!['message'] != null) {
                              return const Center(
                                child: Text('No product sales data available'),
                              );
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
                          future: getSalesDataForChart(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!['dates'].isEmpty) {
                              return const Center(
                                  child: Text(
                                      'No sales data available for the chart.'));
                            }

                            final dates = snapshot.data!['dates'];
                            final values = snapshot.data!['values'];
                            final maxY = snapshot.data!['maxY'] ?? 200.0;
                            final minY = snapshot.data!['minY'] ?? 0.0;

                            return CustomLineChart(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              months: dates.cast<String>(),
                              values: values.cast<double>(),
                              maxY: maxY,
                              minY: minY,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
