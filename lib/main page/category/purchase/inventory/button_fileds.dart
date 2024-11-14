

import 'package:flutter/material.dart';

class ElevatedButtonField extends StatelessWidget {
  final String text;
  final bool isSelected; 
  final VoidCallback onPressed;

  const ElevatedButtonField({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.black : const Color.fromARGB(255, 198, 198, 198),
        ),
        onPressed: onPressed,
        child: Text(text,style: TextStyle(
          color:  isSelected ? Colors.white : const Color.fromARGB(255, 78, 78, 78),
        ),),
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey,
          padding: const EdgeInsets.all(10),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSelected ? 18 : 14,
          ),
        ),
      ),
    );
  }
}