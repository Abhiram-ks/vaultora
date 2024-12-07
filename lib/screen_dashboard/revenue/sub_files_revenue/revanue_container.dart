import 'package:flutter/material.dart';

import '../../../../../Color/colors.dart';

class RevanueContainer extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const RevanueContainer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.1,
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
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      'Track and Analyze Revenue',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text(
                      'Here\'s an overview of your store',
                      style: TextStyle(
                        color: Color.fromARGB(255, 227, 227, 227),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.025,
                  bottom: screenHeight * 0.025,
                  left: screenWidth * 0.045),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.auto_graph_sharp,
                    color: whiteColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}