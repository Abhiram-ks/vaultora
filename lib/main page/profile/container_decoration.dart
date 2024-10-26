import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
  final String text; // Text to display
  final double sigmaX; 
  final double sigmaY; 
  final double? height;

  const BlurredContainer({
    Key? key,
    required this.text,
    this.sigmaX = 10.0,
    this.sigmaY = 10.0,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
            width: double.infinity, 
            height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.48),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}


class InkWellButton extends StatelessWidget {
  final VoidCallback onPressed; // Function to execute on press
  final String text;

  const InkWellButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, 
      borderRadius: BorderRadius.circular(8),
      child: Container(
        constraints:const BoxConstraints(
          minWidth: 100, 
          minHeight: 40, 
        ),
        child: ElevatedButton(
          onPressed: onPressed, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.zero, 
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
