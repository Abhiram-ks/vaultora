import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/overview/perdays/day_helper.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/total_sales_continer.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/totalreve_card.dart';

class DayWise extends StatelessWidget {
  const DayWise({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final ValueNotifier<Map<String, dynamic>> salesDataNotifier =
        ValueNotifier({"todaySales": 0.0, "percentageChange": 0.0});
    final ValueNotifier<int> todaySalesCountNotifier = ValueNotifier(0);
    List<Color> segmentColors = [Colors.pink, Colors.green, Colors.blue, Colors.yellow, Colors.orange];
    
    getTodayAndPreviousComparison().then((date) {
      salesDataNotifier.value = date;
    });

    getTodaySalesCount().then((count) {
      todaySalesCountNotifier.value = count;
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
    return FutureBuilder<Map<String, dynamic>>(
      future: getTopSoldProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No product sales data available'));
        }

        final productData = snapshot.data!;

        return PieChartWidget(
          screenHeight: MediaQuery.of(context).size.height,
          screenWidth: MediaQuery.of(context).size.width,
          segmentColors: [
            Colors.pink, 
            Colors.green, 
            Colors.blue, 
            Colors.yellow, 
            Colors.orange
          ],
          segmentValues: productData['segmentValues'],
          segmentLabels: productData['segmentLabels'],
          sublabel: productData['subLabels'],
        );
      },
    );
  },
)

          ],
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final List<Color> segmentColors;
  final List<double> segmentValues;
  final List<String> segmentLabels;
    final List<String> sublabel;

  const PieChartWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.segmentColors,
    required this.segmentValues,
    required this.segmentLabels,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rowData = List.generate(
        segmentLabels.length,
        (index) => {
              "color": segmentColors[index % segmentColors.length],
              "label": segmentLabels[index],
              "sublsbel":sublabel[index]
            });

    return PinchToZoomScrollableWidget(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: screenWidth,
          height: screenHeight * 0.3,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: Container(
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 29, 66, 77).withOpacity(0.1),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.08,
                          left: screenWidth * 0.01,
                        ),
                        child: Column(
                          children: rowData.map((data) {
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: data["color"],
                                    width: screenHeight * 0.015,
                                    height: screenHeight * 0.015,
                                  ),
                                ), SizedBox(width: screenWidth*0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data["label"],
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      data["sublsbel"],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                          
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          sections:
                              List.generate(segmentValues.length, (index) {
                            return PieChartSectionData(
                              value: segmentValues[index],
                              color: segmentColors.isNotEmpty
                                  ? segmentColors[index % segmentColors.length]
                                  : Colors.blue,
                              showTitle: true,
                              title: '${segmentValues[index]}%',
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              radius: 50 + (index * 10),
                              badgePositionPercentageOffset: 1.2,
                            );
                          }),
                          sectionsSpace: 2,
                          centerSpaceRadius: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
