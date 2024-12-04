

import 'package:flutter/material.dart';

import '../../../Color/colors.dart';

class CustomSnackBarTwo {
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style:  TextStyle(color:redColor )),
        duration: duration,
        behavior: behavior,
        elevation: 10,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
    );
  }
}
