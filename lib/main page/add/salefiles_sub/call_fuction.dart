import 'package:flutter/material.dart';

class CustomDialog {
  static void showStockAlertSnackBar(
    BuildContext context, {
    required String productName,
  }) {
    final snackBar = SnackBar(
      content: Text(
        'The product "$productName" is out of stock.',
        style: const TextStyle(fontSize: 14, color: Colors.red),
        overflow: TextOverflow.ellipsis,
        maxLines: 1, 
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      padding: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 3),
    );
     
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
