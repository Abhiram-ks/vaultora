import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSuccessSnackBar(BuildContext context, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Success !   ',style: TextStyle(fontSize: 22),)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('$itemName added to sales list!')),
          ],
        ),
        backgroundColor: Colors.green[300],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(16.0),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
          },
        ),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('No product selected!'),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(10.0),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}
