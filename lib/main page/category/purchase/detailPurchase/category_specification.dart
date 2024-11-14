import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySpecification extends StatelessWidget {
  final String volume;

  const CategorySpecification({
    super.key,
    required this.volume,
  });
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:screenWidth*0.05,vertical: screenHeight*0.05),
      child: Container(
        height: screenHeight * 0.06,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 134, 134, 134),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Row(
            children: [
              const SizedBox(width: 15),
              const Icon(Icons.headset),
              const SizedBox(width: 8),
              Text(
                volume,
                style: GoogleFonts.kodchasan(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}