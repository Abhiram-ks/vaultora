import 'dart:ui';
import 'package:flutter/material.dart';


class InkWellButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final buttomColor;
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


class BlurredContainer extends StatelessWidget {
  final IconData icon; 
  final String maintext;
  final String text;
  final double sigmaX;
  final double sigmaY;
  final double? height;

  const BlurredContainer({
    super.key,
    required this.icon,
    required this.maintext,
    required this.text,
    this.sigmaX = 10.0,
    this.sigmaY = 10.0,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            maintext,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              width: double.infinity,
              height: height,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 34, 34, 34).withOpacity(0.40),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.grey,size: 15,),
                  SizedBox(width:screenWidth*0.03,),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



