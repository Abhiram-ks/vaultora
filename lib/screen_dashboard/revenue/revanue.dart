import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';

import '../../db/helpers/addfunction.dart';
import '../../db/helpers/salefuction.dart';
import 'sub_files_revenue/revanue_container.dart';
import '../common/appbar.dart';
import 'tap_bar/monitor.dart';
import 'sub_files_revenue/gradient_container.dart';

class RevanuePage extends StatefulWidget {
  const RevanuePage({super.key});

  @override
  State<RevanuePage> createState() => _RevanuePageState();
}

class _RevanuePageState extends State<RevanuePage> {
  final ValueNotifier<double> totalRevenueNotifier = ValueNotifier<double>(0.0);
  bool _isIconDisabled = false;
  bool _showTutorial = true;

  @override
  void initState() {
    super.initState();
    calculateTotalRevenue();
    getAllItems();
    getAllSales();
  }

  void _onIconPressed() {
    if (mounted) {
      setState(() {
        _isIconDisabled = true;
        _showTutorial = false;
      });
    }
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const MonitoringRevenue(),));
  }

  Future<void> calculateTotalRevenue() async {
    try {
      if (!Hive.isBoxOpen('salesModelBox')) {
        await Hive.openBox<SalesModel>('salesModelBox');
      }

      final box = Hive.box<SalesModel>('salesBox');

      if (box.isEmpty) {
        log("The salesModelBox is empty. Total revenue is 0.0.");
        if (mounted) {
          setState(() {
            totalRevenueNotifier.value = 0.0;
          });
        }
        return;
      }

      double totalRevenue = 0.0;
      for (var sale in box.values) {
        final price = double.tryParse(
                sale.totalPrice.replaceAll('₹', '').replaceAll(',', '')) ??
            0.0;
        totalRevenue += price;
      }

      if (mounted) {
        setState(() {
          totalRevenueNotifier.value = totalRevenue;
        });
      }
    } catch (e) {
      log("Error calculating total revenue: $e");
      if (mounted) {
        setState(() {
          totalRevenueNotifier.value = 0.0;
        });
      }
    }
  }

  @override
  void dispose() {
    totalRevenueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:  MyAppBarTwo(titleText: 'Revenue',bgColor: inside,),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                RevanueContainer(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.5,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.025,
                    mainAxisSpacing: screenHeight * 0.015,
                    children: [
                      ValueListenableBuilder<double>(
                        valueListenable: totalRevenueNotifier,
                        builder: (context, totalRevenue, _) {
                          final formatter = NumberFormat("#,##0.00", "en_US");
                              String formattedRevenue = formatter.format(totalRevenue);


                          return RevenueDetailsContainer(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 30, 104, 32),
                                Color.fromARGB(255, 184, 255, 186),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            title: 'Total Sales',
                            icon: Icons.attach_money,
                            salesText: '₹ $formattedRevenue',
                            iconColor: const Color.fromARGB(255, 160, 196, 139),
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: addListNotifier,
                        builder: (context, List<AddModel> items, child){
                          double totalStockValue = items
                        .where((item) => item.itemCount != '0')
                        .map((item) {
                          double mrp = double.tryParse(item.mrp) ?? 0.0;
                      int itemCount = int.tryParse(item.itemCount) ?? 0;
                      return mrp * itemCount;
                        }).fold(0.0, (sum, value) => sum + value);
                            final formatter = NumberFormat("#,##0.00", "en_US");
                              String formattedTotalStockValue = formatter.format(totalStockValue);

                        return  RevenueDetailsContainer(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 14, 72, 119),
                              Color.fromARGB(255, 160, 212, 255)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          screenHeight: MediaQuery.of(context).size.height,
                          screenWidth: MediaQuery.of(context).size.width,
                          title: 'Remaning Value',
                          icon: Icons.shopping_basket,
                          salesText:  '₹ $formattedTotalStockValue',
                          iconColor: const Color.fromARGB(255, 118, 171, 215),
                        );
                        }
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: itemCountNotifier,
                          builder:  (context, count, child){
                            return RevenueDetailsContainer(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.orange,
                              Color.fromARGB(255, 255, 220, 164)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          screenHeight: MediaQuery.of(context).size.height,
                          screenWidth: MediaQuery.of(context).size.width,
                          title: 'Total Product',
                          icon: Icons.assignment_turned_in,
                          salesText: count.toString(),
                          iconColor: const Color.fromARGB(255, 255, 225, 181),
                        );
                      
                          }
                        ),
                      
                      ValueListenableBuilder(
                        valueListenable: saleCountNotifier,
                        builder:  (context, count, child){
                          return  RevenueDetailsContainer(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.purple,
                              Color.fromARGB(255, 245, 186, 255),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          screenHeight: MediaQuery.of(context).size.height,
                          screenWidth: MediaQuery.of(context).size.width,
                          title: 'Total Customers',
                          icon: Icons.people,
                          salesText: count.toString(),
                          iconColor: const Color.fromARGB(255, 248, 181, 255),
                        );
                        }
                        
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (_showTutorial)
            GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _showTutorial = false;
                  });
                }
              },
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tap this button to see inventory details!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                        heroTag: "tutorial_button",
                        onPressed: _onIconPressed,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: const Icon(
                          Icons.bar_chart_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "main_button",
        onPressed: _onIconPressed,
        backgroundColor: Colors.white,
        child: Icon(
          _isIconDisabled ? Icons.pie_chart_rounded : Icons.bar_chart_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
