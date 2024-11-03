import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenteredImageWithText extends StatefulWidget {
  final String imagePath;
  final String text;

  const CenteredImageWithText({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  State<CenteredImageWithText> createState() => _CenteredImageWithTextState();
}

class _CenteredImageWithTextState extends State<CenteredImageWithText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.imagePath,
            height: screenHeight * 0.3,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: const [
                        Color.fromARGB(255, 170, 170, 170),
                        Colors.white,
                        Color.fromARGB(255, 166, 166, 166),

                      ],
                      stops: [
                        _animation.value - 0.2,
                        _animation.value,
                        _animation.value + 0.2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: child,
                );
              },
              child: Text(
                widget.text,
                style: GoogleFonts.roboto(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
