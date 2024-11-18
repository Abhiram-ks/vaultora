import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../db/functions/categoryfunction.dart';

void showDeleteConfirmation(BuildContext context, String categoryId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Row(
          children: [
                 Lottie.asset(
                'assets/category/delete.json',
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
              await deleteCategory(categoryId);
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


 
