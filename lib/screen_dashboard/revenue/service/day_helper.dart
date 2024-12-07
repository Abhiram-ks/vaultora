
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/db/helpers/salefuction.dart';

import '../../../db/models/sales/onsale.dart';

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

bool isToday(DateTime saleDate) {
  final now = DateTime.now();
  return saleDate.year == now.year &&
      saleDate.month == now.month &&
      saleDate.day == now.day;
}

Future<Map<String, dynamic>> getTopSoldProducts({int topN = 4}) async {
  await initSalesDB();
  if (salesListNotifier.value.isEmpty) {
    return {"message": "No sales data available"};
  }

  Map<String, int> productCounts = {};
  Map<String, double> productTotalSales = {};
  List<SalesModel> todaySales = salesListNotifier.value.where((sale) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return DateFormat('yyyy-MM-dd').format(saleDate) == todayString;
  }).toList();
  for (var sale in todaySales) {
    for (var saleProduct in sale.saleProduct) {
      String productName = saleProduct.product.itemName;
      int count = int.tryParse(saleProduct.count) ?? 0;
      double salePrice = double.tryParse(saleProduct.price) ?? 0.0;

      productCounts[productName] = (productCounts[productName] ?? 0) + count;
      productTotalSales[productName] =
          (productTotalSales[productName] ?? 0) + (count * salePrice);
    }
  }

  if (productCounts.isEmpty) {
    return {"message": "No sales data available for today"};
  }
  var sortedProducts = productCounts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  int totalCount = productCounts.values.reduce((a, b) => a + b);

  List<Map<String, dynamic>> segments = [];
  int othersCount = 0;
  double othersTotalPercentage = 0;

  for (int i = 0; i < sortedProducts.length; i++) {
    String productName = sortedProducts[i].key;
    int count = sortedProducts[i].value;
    double percentage = (count / totalCount) * 100;

    if (i < topN) {
      segments.add({
        'value': double.parse(percentage.toStringAsFixed(2)),
        'label': productName,
        'subLabel': "$count sales (${percentage.toStringAsFixed(2)}%)"
      });
    } else {
      othersCount += count;
      othersTotalPercentage += percentage;
    }
  }

  if (othersCount > 0) {
    segments.add({
      'value': double.parse(othersTotalPercentage.toStringAsFixed(2)),
      'label': "Others",
      'subLabel': "$othersCount sales (${othersTotalPercentage.toStringAsFixed(2)}%)"
    });
  }

segments.sort((a, b) => (a['value'] as double).compareTo(b['value']));

List<double> segmentValues = segments.map((s) => s['value'] as double).toList();
List<String> segmentLabels = segments.map((s) => s['label'] as String).toList();
List<String> subLabels = segments.map((s) => s['subLabel'] as String).toList();

  return {
    'segmentValues': segmentValues,
    'segmentLabels': segmentLabels,
    'subLabels': subLabels,
  };
}


Future<Map<String, dynamic>> getSalesDataForChart() async {
  await initSalesDB();
  Map<String, double> dailySales = {};
  final today = DateTime.now();
  final todayString = DateFormat('yyyy-MM-dd').format(today);
  final yesterdayString = DateFormat('yyyy-MM-dd').format(today.subtract(const Duration(days: 1)));
  final dayBeforeYesterdayString = DateFormat('yyyy-MM-dd').format(today.subtract(const Duration(days: 2)));

  for (var sale in salesListNotifier.value) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    final saleDateString = DateFormat('yyyy-MM-dd').format(saleDate);


    if (saleDateString == todayString) {
      dailySales[todayString] = (dailySales[todayString] ?? 0) + (double.tryParse(sale.totalPrice) ?? 0.0);
    } else if (saleDateString == yesterdayString) {
      dailySales[yesterdayString] = (dailySales[yesterdayString] ?? 0) + (double.tryParse(sale.totalPrice) ?? 0.0);
    } else if (saleDateString == dayBeforeYesterdayString) {
      dailySales[dayBeforeYesterdayString] = (dailySales[dayBeforeYesterdayString] ?? 0) + (double.tryParse(sale.totalPrice) ?? 0.0);
    }
  }

  double maxY = 200.0;
  double minY = 0.0;

  if (dailySales.isNotEmpty) {
    maxY = dailySales.values.reduce((a, b) => a > b ? a : b) * 1.2;

    double smallestValue = dailySales.values.reduce((a, b) => a < b ? a : b);
    minY = smallestValue - (smallestValue * 0.25); 
  }

  log('Daily Sales Data: $dailySales');
  return {
    'dates': dailySales.keys.toList(),
    'values': dailySales.values.toList(),
    'maxY': maxY,
    'minY': minY,
  };
} 