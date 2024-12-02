
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class ShaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Animation<double> animation;

  const ShaderText({
    required this.text,
    required this.fontSize,
    required this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors:  [
                const Color.fromARGB(255, 58, 58, 58),
                whiteColor,
              const  Color.fromARGB(255, 100, 100, 100),
              ],
              stops: [
                animation.value - 0.2,
                animation.value,
                animation.value + 0.2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: whiteColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
