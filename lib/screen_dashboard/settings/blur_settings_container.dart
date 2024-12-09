import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
class ClickableRowItem extends StatelessWidget {
  final IconData icon; 
  final String text;   
  final VoidCallback onTap; 
  // ignore: prefer_typing_uninitialized_variables
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
                  backgroundColor: transParent,
                  child: SizedBox(
                    height: screenHeight*0.07,
                    width: screenWidth*0.07,
                    child: Icon(icon, color: whiteColor)),
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
             Icon(Icons.arrow_forward_ios, size: 16, color:whiteColor), 
          ],
        ),
      ),
    );
  }
}

