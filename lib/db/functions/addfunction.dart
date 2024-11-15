import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/db/models/add/add.dart';
import 'package:flutter/foundation.dart';


ValueNotifier<int> itemCountNotifier = ValueNotifier(0);
ValueNotifier<AddModel?> currentiteamNotifier = ValueNotifier<AddModel?>(null);
ValueNotifier<List<AddModel>> addListNotifier = ValueNotifier([]);
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
        purchaseRate: item.purchaseRate, 
        mrp: mrp,
        itemCount:itemCount,      
        totalPurchase: item.totalPurchase,
        dropDown: item.dropDown,
        imagePath: imagePath ?? item.imagePath, 
      );

      await addBox!.put(id, updatedItem);
      await getAllItems();
      log("Item updated successfully: $itemName");
      currentiteamNotifier.value = updatedItem;
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
    addListNotifier.value = addBox!.values.toList()
      ..sort((a, b) => a.itemName.toLowerCase().compareTo(b.itemName.toLowerCase()));
    addListNotifier.notifyListeners();

    itemCountNotifier.value = addBox!.length;
  } else {
    log("Error: addBox is null or not opened");
  }
}

Future<void> deleteItem(String id) async {
  await initAddDB();
  await addBox!.delete(id);
  await getAllItems();
}

void printAllItems() {
  for (var item in addListNotifier.value) {
    log('Item: ${item.itemName}, Description: ${item.description}, '
        'Purchase Rate: ${item.purchaseRate}, MRP: ${item.mrp}, '
        'Item Count: ${item.itemCount}, Total Purchase: ${item.totalPurchase},Dropdown: ${item.dropDown}');
  }
}
