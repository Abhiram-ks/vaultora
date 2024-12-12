import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/common/snackbar.dart';



ValueNotifier<int> itemCountNotifier = ValueNotifier(0);
ValueNotifier<AddModel?> currentiteamNotifier = ValueNotifier<AddModel?>(null);
ValueNotifier<List<AddModel>> addListNotifier = ValueNotifier([]);
List<AddModel> originalItemList = [];
Box<AddModel>? addBox;


Future<void> initAddDB() async {
  if (addBox == null) {
    addBox = await Hive.openBox<AddModel>('add_db');
    log("add_db box opened");
  } else {
    log("add_db box is already open");
  }
}

Future<bool> addItem({
  required String id,
  required String userId,
  required String itemName,
  required String description,
  required String purchaseRate,
  required String mrp,
  required String itemCount,
  required String totalPurchase,
  required String dropDown,
  required String imagePath,
}) async {
  await initAddDB();

  try {
    final newItem = AddModel(
      id: id,
      userid: userId,
      itemName: itemName,
      description: description,
      purchaseRate: purchaseRate,
      mrp: mrp,
      itemCount: itemCount,
      totalPurchase: totalPurchase,
      dropDown:dropDown ,
      imagePath: imagePath, 
    );

    await addBox!.put(id, newItem);
    await getAllItems();
    log("Item added successfully: $itemName");
    return true;
  } catch (e) {
    log("Error adding item: $e");
    return false;
  }
}

Future<bool> updateItem({
  required String id,
  required String itemName,
  required String description,
  required String itemCount,
  required String mrp,
  required String dropDown,
  required String purchaseRate,
  String? imagePath,
}) async {
  await initAddDB();

  try {
    AddModel? item = addBox!.get(id);
    if (item != null) {
      AddModel updatedItem = AddModel(
        id: item.id,
        userid: item.userid,
        itemName: itemName,
        description: description,
        purchaseRate:purchaseRate, 
        mrp: mrp,
        itemCount:itemCount,      
        totalPurchase: item.totalPurchase,
        dropDown: dropDown,
        imagePath: imagePath ?? item.imagePath, 
      );

      await addBox!.put(id, updatedItem);
      await getAllItems();
      log("Item updated successfully: $itemName");
      currentiteamNotifier.value = updatedItem;
      // ignore: invalid_use_of_protected_member
      currentiteamNotifier.notifyListeners();
      return true;
    } else {
      log("Item not found: $id");
      return false;
    }
  } catch (e) {
    log("Error updating item: $e");
    return false;
  }
}



Future<void> getAllItems() async {
  await initAddDB();
  if (addBox != null && addBox!.isOpen) {
    originalItemList = addBox!.values.toList()
      ..sort((a, b) => a.itemName.toLowerCase().compareTo(b.itemName.toLowerCase()));
    addListNotifier.value = List.from(originalItemList);
    // ignore: invalid_use_of_protected_member
    addListNotifier.notifyListeners();

    itemCountNotifier.value = addBox!.length;
  } else {
    log("Error: addBox is null or not opened");
  }
}


Future<void> deleteItem(String id, BuildContext context) async {
  await initAddDB();
  AddModel? item = addBox!.get(id);
  if (item != null) {
    int itemCount = int.tryParse(item.itemCount) ?? 0;
    if (itemCount == 0) {
      await addBox!.delete(id);
      await getAllItems();
      log("Item deleted successfully: ${item.itemName}");
      CustomSnackBarCustomisation.show(
        context: context, 
        message: 'Successfully deleted Item', 
        messageColor:green, 
        icon: Icons.cloud_done_outlined,
         iconColor:green);
      Navigator.of(context).pop();
    } else {
       CustomSnackBarCustomisation.show(
        context: context, 
        message: "Stock is available for the item.",
         messageColor: orange,
          icon: Icons.shopping_cart,
           iconColor: orange);
    }
  } else {
    log("Item not found: $id");
  }
}

void printAllItems() {
  for (var item in addListNotifier.value) {
    log('Item: ${item.itemName}, Description: ${item.description}, '
        'Purchase Rate: ${item.purchaseRate}, MRP: ${item.mrp}, '
        'Item Count: ${item.itemCount}, Total Purchase: ${item.totalPurchase},Dropdown: ${item.dropDown}');
  }
}


Future<double> getMaxMRP() async{
  await initAddDB();

  if (addBox != null && addBox!.isOpen) {
    final mrps = addBox!.values
        .map((item) => double.tryParse(item.mrp) ?? 0.0)
        .toList();
   if (mrps.isNotEmpty) {
      return mrps.reduce((a, b) => a > b ? a : b);
    }
  }
   return 0.0; 
}