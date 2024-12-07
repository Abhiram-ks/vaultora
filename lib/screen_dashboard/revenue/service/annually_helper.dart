import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';

import '../../../db/helpers/salefuction.dart';

Future<double> calculateTotalSalesByYear(DateTime date) async {
  await initSalesDB();

  final yearString = DateFormat('yyyy').format(date);
  double totalSales = salesListNotifier.value
      .where((sale) =>
          DateFormat('yyyy').format(DateTime.fromMicrosecondsSinceEpoch(
              int.tryParse(sale.id) ?? 0)) ==
          yearString)
      .fold(0.0, (prev, sale) {
        final salePrice = double.tryParse(sale.totalPrice) ?? 0.0;
        return prev + salePrice;
      });

  return totalSales;
}

Future<Map<String, dynamic>> getYearlyAndPreviousComparison() async {
  final now = DateTime.now();

  final firstDayOfThisYear = DateTime(now.year, 1, 1);
  final firstDayOfPreviousYear = DateTime(now.year - 1, 1, 1);
  double thisYearSales = await calculateTotalSalesByYear(firstDayOfThisYear);
  double previousYearSales = await calculateTotalSalesByYear(firstDayOfPreviousYear);

  double percentageChange;
  if (previousYearSales > 0) {
    percentageChange = ((thisYearSales - previousYearSales) / previousYearSales) * 100;
  } else {
    percentageChange = 0.0;
  }
  
  return {
    "thisYearSales": thisYearSales,
    "percentageChange": percentageChange,
  };
}

Future<int> getCurrentYearSalesCount() async {
  await initSalesDB();

  final now = DateTime.now();
  final currentYear = now.year;

  int count = salesListNotifier.value
      .where((sale) {
        final saleDate = DateTime.fromMicrosecondsSinceEpoch(
            int.tryParse(sale.id) ?? 0);
        return saleDate.year == currentYear;
      })
      .length;

  return count;
}


Future<Map<String, dynamic>> groupSalesByProductForYear() async {
  await initSalesDB();
  Map<String, int> productCounts = {};
  Map<String, double> productTotalSales = {};
  final currentYearString = DateFormat('yyyy').format(DateTime.now());

  List<SalesModel> yearSales = salesListNotifier.value.where((sale) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    return DateFormat('yyyy').format(saleDate) == currentYearString;
  }).toList();

  for (var sale in yearSales) {
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
    return {"message": "No sales data available for this year"};
  }

  Map<String, dynamic> result = {};
  productCounts.forEach((productName, count) {
    result[productName] = {
      'count': count,
      'totalSales': productTotalSales[productName],
    };
  });

  return result;
}

Future<Map<String, dynamic>> getTopSoldProductsForYear({int topN = 4}) async {
  await initSalesDB();
  if (salesListNotifier.value.isEmpty) {
    return {"message": "No sales data available"};
  }

  Map<String, int> productCounts = {};
  Map<String, double> productTotalSales = {};
  final currentYearString = DateFormat('yyyy').format(DateTime.now());
  List<SalesModel> yearSales = salesListNotifier.value.where((sale) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    return DateFormat('yyyy').format(saleDate) == currentYearString;
  }).toList();
  for (var sale in yearSales) {
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
    return {"message": "No sales data available for this year"};
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

Future<Map<String, dynamic>> getSalesDataForChartYear() async {
  await initSalesDB();
  Map<String, double> yearlySales = {};

  final currentYear = DateTime.now().year;
  final previousYear = currentYear - 1;
  final twoYearsAgo = currentYear - 2;

  yearlySales[currentYear.toString()] = 0.0;
  yearlySales[previousYear.toString()] = 0.0;
  yearlySales[twoYearsAgo.toString()] = 0.0;

  for (var sale in salesListNotifier.value) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    final saleYear = saleDate.year.toString();

    if (saleYear == currentYear.toString()) {
      yearlySales[currentYear.toString()] =
          (yearlySales[currentYear.toString()] ?? 0.0) +
          (double.tryParse(sale.totalPrice) ?? 0.0);
    } else if (saleYear == previousYear.toString()) {
      yearlySales[previousYear.toString()] =
          (yearlySales[previousYear.toString()] ?? 0.0) +
          (double.tryParse(sale.totalPrice) ?? 0.0);
    } else if (saleYear == twoYearsAgo.toString()) {
      yearlySales[twoYearsAgo.toString()] =
          (yearlySales[twoYearsAgo.toString()] ?? 0.0) +
          (double.tryParse(sale.totalPrice) ?? 0.0);
    }
  }

  double maxY = 200.0;
  double minY = 0.0;

  if (yearlySales.isNotEmpty) {
    maxY = yearlySales.values.reduce((a, b) => a > b ? a : b) * 1.2;

    double smallestValue = yearlySales.values.reduce((a, b) => a < b ? a : b);
    minY = smallestValue - (smallestValue * 0.25);
  }

  return {
    'years': [twoYearsAgo.toString(), previousYear.toString(), currentYear.toString()],
    'values': [
      yearlySales[twoYearsAgo.toString()] ?? 0.0,
      yearlySales[previousYear.toString()] ?? 0.0,
      yearlySales[currentYear.toString()] ?? 0.0,
    ],
    'maxY': maxY,
    'minY': minY,
  };
}
