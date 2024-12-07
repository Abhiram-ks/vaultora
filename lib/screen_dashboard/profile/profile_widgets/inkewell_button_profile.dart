import 'package:flutter/material.dart';


class InkWellButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final buttomColor;
  // ignore: prefer_typing_uninitialized_variables
  final textColor;

  const InkWellButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.buttomColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, 
      borderRadius: BorderRadius.circular(8),
      child: Container(
        constraints:const BoxConstraints(
          minWidth: double.infinity, 
          minHeight: 40, 
        ),
        child: ElevatedButton(
          onPressed: onPressed, 
          style: ElevatedButton.styleFrom(
            backgroundColor: buttomColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.zero, 
          ),
          child: Text(
            text,
            style:  TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}



