import 'package:intl/intl.dart';

import '../../../db/models/sales/onsale.dart';
import '../../../db/helpers/salefuction.dart';

Future<double> calculateTotalSalesByMonth(DateTime date) async {
  await initSalesDB();

  final monthString = DateFormat('yyyy-MM').format(date);

  double totalSales = salesListNotifier.value
      .where((sale) =>
          DateFormat('yyyy-MM').format(DateTime.fromMicrosecondsSinceEpoch(
              int.tryParse(sale.id) ?? 0)) == 
          monthString)
      .fold(0.0, (prev, sale) {
        final salePrice = double.tryParse(sale.totalPrice) ?? 0.0;
        return prev + salePrice;
      });

  return totalSales;
}

Future<Map<String, dynamic>> getMonthlyAndPreviousComparison() async {
 final now = DateTime.now();
 final firstDayOfThisMonth = DateTime(now.year, now.month, 1);
  final firstDayOfPreviousMonth = DateTime(now.year, now.month - 1, 1);
   
  double thisMonthSales = await calculateTotalSalesByMonth(firstDayOfThisMonth);
  double previousMonthSales =
      await calculateTotalSalesByMonth(firstDayOfPreviousMonth);

double percentageChange;
if(previousMonthSales > 0){
    percentageChange = ((thisMonthSales - previousMonthSales) / previousMonthSales) * 100;
}else {
 percentageChange = 0.0;
}return {
    "thisMonthSales": thisMonthSales,
    "percentageChange": percentageChange,
};
}


Future<int> getCurrentMonthSalesCount() async {
  await initSalesDB();

  final now = DateTime.now();
  final currentYear = now.year;
  final currentMonth = now.month;

  int count = salesListNotifier.value
      .where((sale) {
        final saleDate = DateTime.fromMicrosecondsSinceEpoch(
            int.tryParse(sale.id) ?? 0);
        return saleDate.year == currentYear && saleDate.month == currentMonth;
      })
      .length;

  return count;
}



Future<Map<String, dynamic>> groupSalesByProductForMonth() async {
  await initSalesDB();
   if (salesListNotifier.value.isEmpty) {
    return {"message": "No sales data available"};
  }

  Map<String, int> productCounts = {};
  Map<String, double> productTotalSales = {};
  final currentMonthString = DateFormat('yyyy-MM').format(DateTime.now());

  List<SalesModel> monthSales = salesListNotifier.value.where((sale) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    return DateFormat('yyyy-MM').format(saleDate) == currentMonthString;
  }).toList();

  for (var sale in monthSales) {
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
    return {"message": "No sales data available for this month"};
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


Future<Map<String, dynamic>> getTopSoldProductsForMonth({int topN = 4}) async {
  await initSalesDB();
  if (salesListNotifier.value.isEmpty) {
    return {"message": "No sales data available"};
  }

  Map<String, int> productCounts = {};
  Map<String, double> productTotalSales = {};
  final currentMonthString = DateFormat('yyyy-MM').format(DateTime.now());

  List<SalesModel> monthSales = salesListNotifier.value.where((sale) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    return DateFormat('yyyy-MM').format(saleDate) == currentMonthString;
  }).toList();

  for (var sale in monthSales) {
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
    return {"message": "No sales data available for this month"};
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


Future<Map<String, dynamic>> getSalesDataForChartMonth() async {
  await initSalesDB();
  Map<String, double> monthlySales = {};

  final today = DateTime.now();
  final currentMonth = DateFormat('MMM').format(today);
  final previousMonth = DateFormat('MMM').format(DateTime(today.year, today.month - 1));
  final twoMonthsAgo = DateFormat('MMM').format(DateTime(today.year, today.month - 2));

  monthlySales[currentMonth] = 0.0;
  monthlySales[previousMonth] = 0.0;
  monthlySales[twoMonthsAgo] = 0.0;

  for (var sale in salesListNotifier.value) {
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(sale.id) ?? 0);
    final saleMonth = DateFormat('MMM').format(saleDate);

    if (saleMonth == currentMonth) {
      monthlySales[currentMonth] = (monthlySales[currentMonth] ?? 0.0) + (double.tryParse(sale.totalPrice) ?? 0.0);
    } else if (saleMonth == previousMonth) {
      monthlySales[previousMonth] = (monthlySales[previousMonth] ?? 0.0) + (double.tryParse(sale.totalPrice) ?? 0.0);
    } else if (saleMonth == twoMonthsAgo) {
      monthlySales[twoMonthsAgo] = (monthlySales[twoMonthsAgo] ?? 0.0) + (double.tryParse(sale.totalPrice) ?? 0.0);
    }
  }

  double maxY = 200.0;
  double minY = 0.0;

  if (monthlySales.isNotEmpty) {
    maxY = monthlySales.values.reduce((a, b) => a > b ? a : b) * 1.2;

    double smallestValue = monthlySales.values.reduce((a, b) => a < b ? a : b);
    minY = smallestValue - (smallestValue * 0.25);
  }

  return {
    'months': [twoMonthsAgo, previousMonth, currentMonth], 
    'values': [
      monthlySales[twoMonthsAgo] ?? 0.0,
      monthlySales[previousMonth] ?? 0.0,
      monthlySales[currentMonth] ?? 0.0,
    ],
    'maxY': maxY,
    'minY': minY,
  };
}
