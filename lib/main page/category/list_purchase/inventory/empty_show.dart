import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FilteringMain extends StatefulWidget {
  const FilteringMain({super.key});

  @override
  State<FilteringMain> createState() => _FilteringMainState();
}

class _FilteringMainState extends State<FilteringMain> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: screenWidth * 0.5,
            height: screenHeight * 0.05,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Lottie.asset(
                  'assets/gif/welcome 2.json',
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.1,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Animation not found');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
