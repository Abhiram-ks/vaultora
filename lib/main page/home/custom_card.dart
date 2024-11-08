import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/colors.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color color;

  const CustomCard(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth * 0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: screenWidth * 0.41,
                height: screenWidth * 0.41,
              ),
            ),
            Container(
              width:
                  screenWidth * 0.41, 
              height: screenWidth * 0.41,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.60),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                title,
                style: GoogleFonts.kodchasan(
                  fontSize: 20,
                  color: textColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
