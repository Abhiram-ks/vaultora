import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../Color/colors.dart';

class StockValue extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String stockValue;

  const StockValue({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.stockValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.04,
            right: screenHeight * 0.01,
            top: screenHeight * 0.01),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Stock Value',
                    style: GoogleFonts.kodchasan(
                      fontSize: 16,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '₹ $stockValue',
                    style: GoogleFonts.kodchasan(
                      fontSize: 20,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Lottie.asset(
                'assets/category/add_sales.json',
                height: screenHeight * 0.07,
                width: screenWidth * 0.15,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}