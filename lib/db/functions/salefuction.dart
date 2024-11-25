import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';



ValueNotifier<List<Map<String, dynamic>>> tempSaleNotifier = ValueNotifier([]);


ValueNotifier<List<SalesModel>> salesListNotifier = ValueNotifier([]);
List<SalesModel> originalSalesList = [];
Box<SalesModel>? salesBox;


ValueNotifier<List<SaleProduct>> saleProductListNotifier = ValueNotifier([]);
Box<SaleProduct>? saleProductBox;

Future<void> initSalesDB() async {
  if (salesBox == null || !salesBox!.isOpen) {
    salesBox = await Hive.openBox<SalesModel>('sales_db');
    log("sales_db box opened");
  } else {
    log("sales_db box is already open");
  }
  if (saleProductBox == null || !saleProductBox!.isOpen) {
    saleProductBox = await Hive.openBox<SaleProduct>('sale_product_db');
    log("sale_product_db box opened");
  } else {
    log("sale_product_db box is already open");
  }
}


Future<bool> addSales({
  required String id,
  required String date,
  required String accountName,
  required String address,
  required String phoneNumber,
  required String salesNumber,
  required String totalPrice,
  required List<SaleProduct> saleProducts,
})async{
    await initSalesDB();

    try{
    
    for(var product in saleProducts){
      await saleProductBox!.put(product.id, product); 
    }

     final newSales = SalesModel(
      id: id,
      date: date,
      accountName: accountName,
      address: address,
      phoneNumber: phoneNumber,
      salesNumber: salesNumber,
      totalPrice: totalPrice,
      saleProduct: saleProducts,
    );
     await salesBox!.put(id, newSales);
     await getAllSales();
    log("Sales added successfully: $id");
    return true;
    } catch(e) {
       log("Error adding sales: $e");
       return false;
    }
}



Future<bool> updateSale({
  required String id,
  String? accountName,
  String? address,
  String? phoneNumber,
}) async {
  await initSalesDB();

  try {
    SalesModel? sale = salesBox!.get(id);
    if (sale != null) {
      final updatedSale = SalesModel(
        id: sale.id,
        date: sale.date,
        accountName: accountName ?? sale.accountName,
        address: address ?? sale.address,
        phoneNumber: phoneNumber ?? sale.phoneNumber,
        salesNumber: sale.salesNumber,
        totalPrice: sale.totalPrice,
        saleProduct: sale.saleProduct,
      );

      await salesBox!.put(id, updatedSale);
      await getAllSales();
      debugPrint("Sale updated successfully.");
      return true;
    } else {
      debugPrint("Sale not found for ID: $id");
      return false;
    }
  } catch (e) {
    debugPrint("Error updating sale: $e");
    return false;
  }
}


Future<void> getAllSales() async {
  await initSalesDB();

  if (salesBox != null && salesBox!.isOpen) {
    salesListNotifier.value = salesBox!.values.toList();
    salesListNotifier.notifyListeners();
  }
}


Future<void> deleteSale(String id) async {
  await initSalesDB();
  final sale = salesBox!.get(id);


  if (sale != null) {
   for (var product in sale.saleProduct) {
    await saleProductBox!.delete(product.id);
   }

  await salesBox!.delete(id);
  await getAllSales();
  log("Sale and its products deleted successfully.");
} else {
   log("Sale not found for ID: $id");
}
}

void printAllSales() {
  for (var sale in salesListNotifier.value) {
    log('Sale: ID: ${sale.id}, Date: ${sale.date}, Account: ${sale.accountName}, Address: ${sale.address}, '
        'Phone: ${sale.phoneNumber}, Sales Number: ${sale.salesNumber}, Total Price: ${sale.totalPrice}');
    for (var product in sale.saleProduct) {
      log('  Product: ID: ${product.id}, mrprate: ${product.mrprate}, Name: ${product.product}, Count: ${product.count}, Price: ${product.price}');
    }
  }
}