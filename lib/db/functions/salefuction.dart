import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/db/functions/addfunction.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


ValueNotifier<List<SaleProduct>> tempSaleNotifier = ValueNotifier([]);
ValueNotifier<List<SalesModel>> salesListNotifier = ValueNotifier([]);
ValueNotifier<int> saleCountNotifier = ValueNotifier(0);
late Box<SalesModel> salesBox;
late Box<int> counterBox;
int salesInvoiceCounter = 1;
List<SalesModel> originalSalesList = []; 




Future<void> initSalesDB() async {
  if (!Hive.isBoxOpen('salesBox')) {
    salesBox = await Hive.openBox<SalesModel>('salesBox');
    log("Sales DB box opened.");
  }
  if (!Hive.isBoxOpen('salescounterBox')) {
    counterBox = await Hive.openBox<int>('salescounterBox');
    salesInvoiceCounter = counterBox.get('invoiceCounter') ?? 1;
    log("Counter DB box opened.");
  } else {
    counterBox = Hive.box<int>('salescounterBox');
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
      salesNumber: "INV-$salesInvoiceCounter",
      saleProduct: List.from(tempSaleNotifier.value),
      totalPrice: totalPrice,
    );

      await updateProductStocks(List.from(tempSaleNotifier.value));
    tempSaleNotifier.value.clear();
    await salesBox.put(newSale.id, newSale);

    salesInvoiceCounter++;
    await counterBox.put('invoiceCounter', salesInvoiceCounter);

    await getAllSales();
    log(newSale.saleProduct.toString());
  
  } catch (e) {
    log("Error in addSale: $e");
  }
 }

Future<void> updateProductStocks(List<SaleProduct> soldProducts) async {
  await initAddDB(); 
  
  for (final soldProduct in soldProducts) {
    final productId = soldProduct.product.id; 
    final quantityToSubtract = int.tryParse(soldProduct.count) ?? 0; 
    
    if (quantityToSubtract <= 0) {
      log("Invalid quantity for product $productId: $quantityToSubtract");
      continue;
    }

    final existingProduct = addBox?.get(productId);

    if (existingProduct != null) {
      final currentStock = int.tryParse(existingProduct.itemCount) ?? 0;

      final updatedStock = currentStock - quantityToSubtract;

      if (updatedStock < 0) {
        log("Stock cannot be negative for product $productId. Current stock: $currentStock, Requested: $quantityToSubtract");
        continue;
      }

      await updateItem(
        id: existingProduct.id,
        itemName: existingProduct.itemName,
        description: existingProduct.description,
        itemCount: updatedStock.toString(), 
        mrp: existingProduct.mrp,
        purchaseRate: existingProduct.purchaseRate,
        dropDown: existingProduct.dropDown,
        imagePath: existingProduct.imagePath,
      );

      log("Stock updated for product $productId. New stock: $updatedStock");
    } else {
      log("Product with ID $productId not found.");
    }
  }

  await getAllItems();
  log("All stocks updated successfully after sale.");
}


Future<bool> updateSale({
  required String id,
  required String accountName,
  required String address,
  required String phoneNumber,
}) async {
  await initSalesDB();

  try {
    SalesModel? sale = salesBox.get(id);
    if (sale != null) {
      SalesModel updatedSale = SalesModel(
        id: id,
        accountName: accountName,
        address: address,
        phoneNumber: phoneNumber,
        salesNumber: sale.salesNumber,
        saleProduct: List.from(sale.saleProduct),
        totalPrice: sale.totalPrice,
      );

      await salesBox.put(id, updatedSale);
      await getAllSales();
      log("Sale updated successfully: ${updatedSale.salesNumber}");
      return true;
    } else {
      log("Sale not found with ID: $id");
      return false;
    }
  } catch (e, stackTrace) {
    log("Error updating sale: $e");
    log("Stack trace: $stackTrace");
    return false;
  }


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
 
Future<void> getAllSales() async {
  await initSalesDB();
  if(addBox != null && addBox!.isOpen){
    originalSalesList = salesBox.values.toList();
    salesListNotifier.value = List.from(originalSalesList);

      // ignore: invalid_use_of_protected_member
    salesListNotifier.notifyListeners();
    saleCountNotifier.value = salesBox.length;
  } else {
    log("Error: SalesBox is null or not opened");
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