import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';


class LogoSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const LogoSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.3,
              height: screenHeight * 0.05,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/welcome/logoblack-removebg-preview.png',
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 1,
                    right: 2,
                    child: Text(
                      'Valtora',
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 8,
                    right: 0,
                    child: Text(
                      'Sales Statement!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                        fontSize: 7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}