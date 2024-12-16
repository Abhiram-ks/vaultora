import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/helpers/addfunction.dart';
import '../../../../../db/helpers/categoryfunction.dart';
import '../../../../common/snackbar.dart';

void showDeleteConfirmation(BuildContext context, String categoryId) async {
 Future<void> deleteCategoryWithCheck(
  BuildContext context, String categoryId) async{   await initCategoryDB();
  await initAddDB();
   final category = categoryBox!.get(categoryId);
   if(category == null){
    log("Category not found: $categoryId");
    return;
   }

   bool isUsedInItems = addBox!.values.any((item) => item.dropDown == category.categoryName);

   if(isUsedInItems){
    CustomSnackBarCustomisation.show(
      context: context,
      icon: Icons.shopping_bag_outlined,
      iconColor: redColor,
      message: 'Cannot delete category as it is in use.',
      messageColor: redColor,
    );
    return;
   }
    await categoryBox!.delete(categoryId);
    log("Category deleted: $categoryId");
      categoryListNotifier.value = categoryBox!.values.toList();
    // ignore: invalid_use_of_protected_member
    categoryListNotifier.notifyListeners();

  CustomSnackBarCustomisation.show(
    context:context,
    icon: Icons.cloud_done_outlined,
    iconColor: green,
    message: 'Category deleted successfully.',
    messageColor: green,
     );

  }
 
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Row(
          children: [
                 Lottie.asset(
                'assets/gif/delete.json',
                width: 80,
                height: 76,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Animation not found');
                },
              ),const SizedBox(width: 10),
               const Flexible(
                child: Text(
                  'Are you sure you want to delete this category?',
                  overflow: TextOverflow.visible,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await deleteCategoryWithCheck(context, categoryId);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Delete', style: TextStyle(
                color: Colors.white,
              ),),
          ),
        ],
      );
    },
  );
}


 
