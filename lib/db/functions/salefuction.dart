import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


ValueNotifier<List<SaleProduct>> tempSaleNotifier = ValueNotifier([]);
ValueNotifier<List<SalesModel>> salesListNotifier = ValueNotifier([]);

late Box<SalesModel> salesBox;
late Box<int> counterBox;
int salesInvoiceCounter = 1;

Future<void> initSalesDB() async {
  if (!Hive.isBoxOpen('salesBox')) {
    salesBox = await Hive.openBox<SalesModel>('salesBox');
    log("Sales DB box opened.");
  }
  if (!Hive.isBoxOpen('salescounterBox')) {
    counterBox = await Hive.openBox<int>('salescounterBox');
    salesInvoiceCounter = counterBox.get('invoiceCounter') ?? 1;
    log("Counter DB box opened.");
  }
}

Future<void> addSale(
 String accountName,
 String phoneNumber, 
 String address,
 String totalPrice,
 ) async {
  try {
    await initSalesDB();

    if (tempSaleNotifier.value.isEmpty) {
      log("No products added to sale.");
      return;
    }

    final newSale = SalesModel(
      id: "${DateTime.now().microsecondsSinceEpoch}",
      accountName: accountName,
      address: address,
      phoneNumber: phoneNumber,
      salesNumber: "IFC-$salesInvoiceCounter",
      saleProduct: List.from(tempSaleNotifier.value),
      totalPrice: totalPrice,
    );

    tempSaleNotifier.value.clear();
    await salesBox.put(newSale.id, newSale);

    salesInvoiceCounter++;
    await counterBox.put('invoiceCounter', salesInvoiceCounter);

    await getAllSales();
    log("Sale added successfully.");
  } catch (e) {
    log("Error in addSale: $e");
  }
}



Future<void> getAllSales() async {
  await initSalesDB();
  salesListNotifier.value = salesBox.values.toList();
  // ignore: invalid_use_of_protected_member
  salesListNotifier.notifyListeners();
}



void printAllSales() {
  for (var sale in salesListNotifier.value) {
    log('Sale: ID: ${sale.id}, Account: ${sale.accountName}, Address: ${sale.address}, '
        'Phone: ${sale.phoneNumber}, Sales Number: ${sale.salesNumber}, Total Price: ${sale.totalPrice}');
    for (var product in sale.saleProduct) {
      log(', Name: ${product.product}, Count: ${product.count},}');
    }
  }
}

Future<void> deleteSale(String id) async {
  try {
    await initSalesDB();
    if (!salesBox.containsKey(id)) {
      log("Sale not found.");
      return;
    }

    await salesBox.delete(id);
    await getAllSales();
    log("Sale deleted successfully.");
  } catch (e) {
    log("Error deleting sale: $e");
  }
}
