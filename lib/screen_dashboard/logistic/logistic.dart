import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/helpers/addfunction.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';
import '../../db/helpers/salefuction.dart';
import 'sub_files_logistic/stock_level_monitoring.dart';
import 'sub_files_logistic/zero_stock_container.dart';
import 'sub_files_logistic/total_stock_value.dart';
import 'sub_files_logistic/zero_stock.dart';
import '../common/appbar.dart';


class LogisticPage extends StatefulWidget {
  const LogisticPage({super.key});

  @override
  State<LogisticPage> createState() => _LogisticPageState();
}

class _LogisticPageState extends State<LogisticPage> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar:  MyAppBarTwo(
        titleText: 'Logistic',
        bgColor: inside,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.012),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.01),
              ValueListenableBuilder(
                  valueListenable: addListNotifier,
                  builder: (context, List<AddModel> items, child) {
                    double totalStockValue = items
                        .where((item) => item.itemCount != '0')
                        .map((item) {
                      double mrp = double.tryParse(item.mrp) ?? 0.0;
                      int itemCount = int.tryParse(item.itemCount) ?? 0;
                      return mrp * itemCount;
                    }).fold(0.0, (sum, value) => sum + value);
                    return StockValue(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      stockValue: totalStockValue.toStringAsFixed(2),
                    );
                  }),
              SizedBox(height: screenHeight * 0.01),
              ValueListenableBuilder(
                valueListenable: addListNotifier,
                builder: (context, List<AddModel> items, child) {
                  final zeroStockItems =
                      items.where((item) => item.itemCount == "0").toList();

                  return ZeroStock(
                    title: 'Zero Stock',
                    description: zeroStockItems.isNotEmpty
                        ? zeroStockItems.map((item) => item.itemName).join(', ')
                        : 'No items in zero stock',
                    gradientColors1: const[
                         Color.fromARGB(255, 59, 140, 164),
                         Color.fromARGB(255, 40, 98, 116),
                    ],
                    gradientColors2: const [
                         Color.fromARGB(255, 59, 140, 164),
                         Color.fromARGB(255, 125, 185, 203),
                    ],
                    right: 10.0,
                    bottom: 10.0,
                    itemCount: zeroStockItems.length,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StockPage(),
                      ));
                    },
                  );
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SizedBox(
                height: screenHeight * 0.5,
                child: ValueListenableBuilder(
                  valueListenable: addListNotifier,
                  builder: (context, List<AddModel> items, child) {
                    if (items.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Lottie.asset(
                                      'assets/category/sale_empty.json',
                                      width: screenWidth * 0.5,
                                      height: screenHeight * 0.3,
                        ),
                        ],
                      );
                    }

                    final sortedItems = List<AddModel>.from(items);
                    sortedItems.sort((a, b) {
                      final productStockA = int.tryParse(a.itemCount) ?? 0;
                      final productStockB = int.tryParse(b.itemCount) ?? 0;

                      return productStockB.compareTo(productStockA);
                    });

                    return ListView.separated(
                      itemCount: sortedItems.length,
                      itemBuilder: (context, index) {
                        final item = sortedItems[index];
                        final totalStock = int.tryParse(item.itemCount) ?? 0;
                        final saleStock = salesListNotifier.value
                            .expand((sale) => sale.saleProduct)
                            .where((saleProduct) =>
                                saleProduct.product.id == item.id)
                            .fold<int>(0, (previous, saleProduct) {
                          return previous +
                              (int.tryParse(saleProduct.count) ?? 0);
                        });
                        final remainingStock = totalStock + saleStock;
                        return StockLevelMonitoring(
                          imagePath: item.imagePath,
                          titleText: item.itemName,
                          productStock: int.tryParse(item.itemCount) ?? 0,
                          saleStock: saleStock,
                          totalStock: remainingStock,
                          statusText:
                              totalStock > 0 ? "In Stock" : "Out of Stock",
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: screenHeight * 0.01,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}