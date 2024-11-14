import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static Future<bool?> show(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: const Text("Cancel",style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: const Text("Delete",style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
