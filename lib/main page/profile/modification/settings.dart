import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

import '../../../colors/colors.dart';
import '../../../login/loginSignin/welcome_screen.dart';

class ClickableRowItem extends StatelessWidget {
  final IconData icon; 
  final String text;   
  final VoidCallback onTap; 
  final bgcolor;

  const ClickableRowItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        height: screenHeight*0.06,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color:const Color.fromARGB(210, 192, 192, 192),
          borderRadius: BorderRadius.circular(12),
        
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: bgcolor,
                  child: SizedBox(
                    height: screenHeight*0.07,
                    width: screenWidth*0.07,
                    child: Icon(icon, color: Colors.white)),
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), 
          ],
        ),
      ),
    );
  }
}

