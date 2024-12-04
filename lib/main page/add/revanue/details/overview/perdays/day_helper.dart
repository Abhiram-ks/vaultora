import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';

import '../../../../../../db/models/sales/onsale.dart';

//helper for sales report
Future<double> calculateTotalSalesByDate(DateTime date) async {
  await initSalesDB();

  final dateString = DateFormat('yyyy-MM-dd').format(date);

  double totalSales = salesListNotifier.value
      .where((sale) =>
          DateFormat('yyyy-MM-dd').format(DateTime.fromMicrosecondsSinceEpoch(
              int.tryParse(sale.id) ?? 0)) ==
          dateString)
      .fold(0.0, (prev, sale){
        // ignore: non_constant_identifier_names
        final SalePrice = double.tryParse(sale.totalPrice) ?? 0.0;
        return prev + SalePrice;
      });

  return totalSales;
}

Future<Map<String, dynamic>> getTodayAndPreviousComparison() async {
  final today = DateTime.now();
  final yesterday = today.subtract(const Duration(days: 1));

  double todaySales = await calculateTotalSalesByDate(today);
  double yesterdaySales = await calculateTotalSalesByDate(yesterday);

  double percentageChange;
  if (yesterdaySales > 0) {
    percentageChange = ((todaySales - yesterdaySales) / yesterdaySales) * 100;
  } else {
    percentageChange = 0.0;
  }

  return {
    "todaySales": todaySales,
    "percentageChange": percentageChange,
  };
}

//helper for sales of the day
Future<int> getTodaySalesCount() async {
  await initSalesDB();

  final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());

  int count = salesListNotifier.value
      .where((sale) =>
          DateFormat('yyyy-MM-dd').format(DateTime.fromMicrosecondsSinceEpoch(
              int.tryParse(sale.id) ?? 0)) ==
          todayString)
      .length;

  return count;
}


Future<Map<String, dynamic>> groupSalesByProduct(List<SalesModel> salesList) async {
  Map<String, dynamic> groupedSales = {};

  for (var sale in salesList) {
    for (var product in sale.saleProduct) {
      String productName = product.product.itemName;
      int count = int.parse(product.count);
      double totalSale = double.parse(product.price) * count;

      if (groupedSales.containsKey(productName)) {
        groupedSales[productName]['total'] += totalSale;
        groupedSales[productName]['count'] += count;
      } else {
        groupedSales[productName] = {
          'total': totalSale,
          'count': count,
        };
      }
    }
  }

  return groupedSales;
}


Future<Map<String, dynamic>> getGroupedSalesData() async {
  List<SalesModel> salesList = salesListNotifier.value;

  Map<String, dynamic> groupedData = {};
  for (var sale in salesList) {
    final accountName = sale.accountName;
    final saleTotal = double.tryParse(sale.totalPrice) ?? 0.0;

    if (groupedData.containsKey(accountName)) {
      groupedData[accountName]["totalSales"] += saleTotal;
      groupedData[accountName]["salesCount"] += 1;
    } else {
      groupedData[accountName] = {
        "totalSales": saleTotal,
        "salesCount": 1,
      };
    }
  }

  return groupedData;
}


Future<Map<String, dynamic>> getTopSoldProducts({int topN = 5}) async {
  await initSalesDB();


  Map<String, int> productCounts = {};
  Map<String, double> productTotalSales = {};

  for (var sale in salesListNotifier.value) {
    for (var saleProduct in sale.saleProduct) {
      String productName = saleProduct.product.itemName;
      int count = int.parse(saleProduct.count);
      double salePrice = double.parse(saleProduct.price);


      productCounts[productName] = (productCounts[productName] ?? 0) + count;
      

      productTotalSales[productName] = 
        (productTotalSales[productName] ?? 0) + (count * salePrice);
    }
  }


  var sortedProducts = productCounts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  List<double> segmentValues = [];
  List<String> segmentLabels = [];
  List<String> subLabels = [];
  double othersTotal = 0;
  int othersCount = 0;


  int totalCount = productCounts.values.reduce((a, b) => a + b);

 
  for (int i = 0; i < sortedProducts.length; i++) {
    if (i < topN) {
      String productName = sortedProducts[i].key;
      int count = sortedProducts[i].value;
      double percentage = (count / totalCount) * 100;

      segmentValues.add(percentage);
      segmentLabels.add(productName);
      subLabels.add("$count sales (${percentage.toStringAsFixed(2)}%)");
    } else {
      othersTotal += (sortedProducts[i].value / totalCount) * 100;
      othersCount += sortedProducts[i].value;
    }
  }


  if (othersTotal > 0) {
    segmentValues.add(othersTotal);
    segmentLabels.add('Others');
    subLabels.add('$othersCount sales (${othersTotal.toStringAsFixed(2)}%)');
  }

  return {
    'segmentValues': segmentValues,
    'segmentLabels': segmentLabels,
    'subLabels': subLabels,
  };
}