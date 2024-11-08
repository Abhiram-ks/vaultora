
import 'package:flutter/material.dart';

class BgimageRegisterLogin extends StatelessWidget {
  const BgimageRegisterLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/welcome/main image.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.73),
        ),
      ],
    );
  }
}
