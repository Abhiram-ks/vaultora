import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';

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
