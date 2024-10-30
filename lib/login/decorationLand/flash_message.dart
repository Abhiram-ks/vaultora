import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';

class FlashMessage {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Container(
          height: 90,
          decoration: BoxDecoration(
            color: redColor, 
            borderRadius: BorderRadius.circular(20)
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('oh shap !',style: TextStyle(fontSize: 18,color: textColor2),),
              Text("Registering...",style: TextStyle(fontSize: 12,color: textColor2)),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
