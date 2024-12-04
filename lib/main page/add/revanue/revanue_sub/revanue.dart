import 'package:flutter/material.dart';


class RevenueDetailsContainer extends StatelessWidget {
  final Gradient gradient;
  final double screenHeight;
  final double screenWidth;
  final IconData icon;
   final Color iconColor; 
  final String salesText;
  final String title;

  const RevenueDetailsContainer({
    super.key,
    required this.gradient,
    required this.screenHeight,
    required this.screenWidth,
    required this.icon,
     required this.iconColor,
    required this.salesText,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
          ),
          width: screenWidth / 2,
          height: screenHeight * 0.2,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  salesText, 
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 1,
          right: 0,
          child: Icon(
            icon,
             color: iconColor, 
            size: 70,
          ),
        ),
      ],
    );
  }
}