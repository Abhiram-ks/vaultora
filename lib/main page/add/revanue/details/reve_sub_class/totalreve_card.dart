
import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class EarningsCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String title;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final String percentageText;

  const EarningsCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.percentageText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.12,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 29, 66, 77),
            Color.fromARGB(255, 135, 181, 195),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    title,
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    amount,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 227, 227, 227),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.032,
                right: screenWidth * 0.006,
                bottom: screenHeight * 0.032,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: iconColor),
                    Text(
                      percentageText,
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}