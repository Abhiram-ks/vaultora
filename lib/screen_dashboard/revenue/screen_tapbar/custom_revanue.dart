import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import '../../common/snackbar.dart';
import '../sub_files_revenue/calender_revenu.dart';
import '../sub_files_revenue/click_for_calender.dart';
import '../sub_files_revenue/total_revenue_card.dart';
import '../../records/sales/subfiles_sales/actions_sale.dart';
import '../service/constom_helper.dart';

class Customisation extends StatefulWidget {
  const Customisation({super.key});

  @override
  State<Customisation> createState() => _CustomisationState();
}

class _CustomisationState extends State<Customisation> {
  ValueNotifier<String> startDateNotifier = ValueNotifier('Start Date');
  ValueNotifier<String> endDateNotifier = ValueNotifier('End Date');
  final ValueNotifier<Future<Map<String, dynamic>>> salesDataNotifier =
      ValueNotifier(Future.value({}));
  ValueNotifier<Future<int>> salesCountNotifier =
      ValueNotifier(Future.value(0));

  final SalesService salesService = SalesService();
  bool isListVisible = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomRevenuCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              startDateNotifier: startDateNotifier,
              endDateNotifier: endDateNotifier,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return DateRangePicker(
                      onDateRangeSelected: (startDate, endDate) {
                        startDateNotifier.value = startDate != null
                            ? startDate.toString().split(' ')[0]
                            : 'Start Date';
                        endDateNotifier.value = endDate != null
                            ? endDate.toString().split(' ')[0]
                            : 'End Date';
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ActionButtons(
                onAddSalePressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: whiteColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Are you sure you want to clear all data?",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    startDateNotifier.value = 'Start Date';
                                    endDateNotifier.value = 'End Date';
                                    salesDataNotifier.value = Future.value({});
                                    isListVisible = false;
                                    Navigator.pop(context);
                                    CustomSnackBarCustomisation.show(
                                        context: context,
                                        message: "All data has been cleared.",
                                        messageColor: green,
                                        icon: Icons.cloud_done_outlined,
                                        iconColor: green);
                                  },
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                onCheckoutPressed: () async {
                  try {
                    final startDate =
                        DateTime.tryParse(startDateNotifier.value);
                    final endDate = DateTime.tryParse(endDateNotifier.value);

                    if (startDate == null || endDate == null) {
                      CustomSnackBarCustomisation.show(
                          context: context,
                          message: "Please select valid start and end dates.!",
                          messageColor: Colors.blue,
                          icon: Icons.info_outline_rounded,
                          iconColor: Colors.blue);
                      return;
                    }
                    final difference = endDate.difference(startDate).inDays;

                    if (difference < 0) {
                      CustomSnackBarCustomisation.show(
                          context: context,
                          message:  "End date cannot be earlier than start date.!",
                          messageColor: Colors.blue,
                          icon: Icons.info_outline_rounded,
                          iconColor: Colors.blue);
                    } else if (difference > 20) {
                      CustomSnackBarCustomisation.show(
                          context: context,
                          message: "Date range exceeds 20 days !",
                          messageColor: redColor,
                          icon: Icons.warning,
                          iconColor: redColor);
                    } else {
                      salesDataNotifier.value =
                          salesService.calculateSalesForCustomDateRange(
                        startDateNotifier.value,
                        endDateNotifier.value,
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                addSaleText: 'Clear',
                checkoutText: 'Apply'),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              height: screenHeight * 0.58,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    ValueListenableBuilder<Future<Map<String, dynamic>>>(
                      valueListenable: salesDataNotifier,
                      builder: (context, futureSalesData, _) {
                        return FutureBuilder<Map<String, dynamic>>(
                          future: futureSalesData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No data available.');
                            } else {
                              final salesData = snapshot.data!;
                              final totalSales = salesData["totalSales"];
                              final dailySales =
                                  salesData["dailySales"] as List<dynamic>;

                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EarningsCard(
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      title: 'Tracker Report',
                                      amount:
                                          '₹ ${totalSales.toStringAsFixed(2)}',
                                      icon: Icons.assignment_turned_in_outlined,
                                      iconColor: Colors.white,
                                      percentageText: '',
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: const Text(
                                            "Detail Sales Report",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              isListVisible
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isListVisible = !isListVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        if (isListVisible)
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: dailySales.length,
                                            itemBuilder: (context, index) {
                                              final dailyData =
                                                  dailySales[index];
                                              return ListTile(
                                                title: Text(
                                                    "Date: ${dailyData['date']}"),
                                                subtitle: Text(
                                                  "Sales: ₹ ${dailyData['totalSales'].toStringAsFixed(2)}",
                                                ),
                                                trailing: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Total Sales:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${dailyData['salesCount']}",
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 29, 66, 77),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    )
                                  ]);
                            }
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
