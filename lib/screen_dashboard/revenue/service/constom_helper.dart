import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../db/models/sales/onsale.dart';


class SalesService {
  late Box<SalesModel> salesBox;

  Future<void> initSalesDB() async {
    if (!Hive.isBoxOpen('salesBox')) {
      salesBox = await Hive.openBox<SalesModel>('salesBox');
    } else {
      salesBox = Hive.box<SalesModel>('salesBox');
    }
  }
Future<Map<String, dynamic>> calculateSalesForCustomDateRange(
    String startDate, String endDate) async {
  if (startDate == 'Start Date' || endDate == 'End Date') {
    throw Exception("Please select both start and end dates.");
  }

  await initSalesDB();

  final start = DateTime.parse(startDate);
  final end = DateTime.parse(endDate);

  double totalSales = 0.0;
  List<Map<String, dynamic>> dailySales = [];
  int totalSalesCount = 0;

  for (var date = start;
      date.isBefore(end.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))) {
    final dateString = DateFormat('dd-MM-yyyy').format(date);

    final dailySalesList = salesBox.values.where((sale) {
      final saleDate =
          DateTime.fromMicrosecondsSinceEpoch(int.parse(sale.id));
      return DateFormat('dd-MM-yyyy').format(saleDate) == dateString;
    }).toList();


    final dailyTotal = dailySalesList.fold(0.0, (sum, sale) {
      return sum + (double.tryParse(sale.totalPrice) ?? 0.0);
    });


    final dailyCount = dailySalesList.length;
    dailySales.add({
      "date": dateString,
      "totalSales": dailyTotal,
      "salesCount": dailyCount,
    });

    totalSales += dailyTotal;
    totalSalesCount += dailyCount;
  }

  return {
    "totalSales": totalSales,
    "dailySales": dailySales,
    "totalSalesCount": totalSalesCount,
  };
}
}