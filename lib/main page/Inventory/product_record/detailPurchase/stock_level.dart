import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockLevel extends StatelessWidget {
  final double width;
  final String text;

  const StockLevel({super.key, required this.width, required this.text});

  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: screenHeight * 0.04,
        width: width,
        padding:const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 197, 197, 197).withOpacity(0.8), 
          borderRadius: BorderRadius.circular(18),
          border: null
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.kodchasan(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
