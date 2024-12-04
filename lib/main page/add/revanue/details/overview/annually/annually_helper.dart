import 'package:intl/intl.dart';

import '../../../../../../db/functions/salefuction.dart';

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
