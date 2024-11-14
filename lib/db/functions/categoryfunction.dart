import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/category/catalog.dart';

ValueNotifier<CategoryModel?> currentCategoryNotifier = ValueNotifier<CategoryModel?>(null);
ValueNotifier<List<CategoryModel>> categoryListNotifier = ValueNotifier<List<CategoryModel>>([]);
Box<CategoryModel>? categoryBox;


Future<void> initCategoryDB() async{
  if(categoryBox == null){
     categoryBox = await Hive.openBox<CategoryModel>('category_db');
    log("category_db box opened");
     categoryListNotifier.value = categoryBox!.values.toList();
  } else {
   log("category_db box is already open");
  }
}

Future<bool> addCategory({
  required String id,
  required String userid,
  required String categoryName,
  required String imagePath,
}) async {
  await initCategoryDB();
  try {
    final newCategory = CategoryModel(
      id: id,
      userid: userid,
      categoryName: categoryName,
      imagePath: imagePath, 
    );
    await categoryBox!.put(id, newCategory);
    log("Category added successfully: $categoryName for user: $userid");
   categoryListNotifier.value = categoryBox!.values.toList();
    categoryListNotifier.notifyListeners();
    return true;
  } catch (e) {
    log("Error adding category: $e");
    return false;
  }
}

Future<bool> updateCategory({
  required String id,
  required String categoryName,
  required String imagePath,
}) async {
  await initCategoryDB();
  try {
    if (categoryBox!.containsKey(id)) {
      final existingCategory = categoryBox!.get(id);
      final updatedCategory = CategoryModel(
        id: existingCategory!.id, 
        userid: existingCategory.userid,
        categoryName: categoryName, 
        imagePath: imagePath,
      );

      await categoryBox!.put(id, updatedCategory);
      log("Category updated successfully: $categoryName with new image path.");
      
      categoryListNotifier.value = categoryBox!.values.toList();
      categoryListNotifier.notifyListeners();
      return true;
    } else {
      log("Category with id $id does not exist.");
      return false;
    }
  } catch (e) {
    log("Error updating category: $e");
    return false;
  }
}


Future<void> deleteCategory(String id) async {
  await initCategoryDB();
  await categoryBox!.delete(id);
  log("Category deleted: $id");

 categoryListNotifier.value = categoryBox!.values.toList();
   categoryListNotifier.notifyListeners();
}


