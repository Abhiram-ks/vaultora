import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  CustomDialog({required this.context});

  void show(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
         title: 'Warning Info',
      desc: 'Please complete all required details...',
    )..show();
  }
}


class CustomError {
  final BuildContext context;
  CustomError({required this.context});

  void show(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
         title: 'Error Info',
      desc: 'Mismatch in entered information...',
    )..show();
  }
}