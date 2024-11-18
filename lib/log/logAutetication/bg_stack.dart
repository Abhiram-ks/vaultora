
import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';



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
          color:textColor1.withOpacity(0.73),
        ),
      ],
    );
  }
}
