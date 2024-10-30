import 'package:flutter/material.dart';

import '../stackBackgroud/background_stack.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
        return const Scaffold(
      body: Stack(
        children: [
          BackgroundStack(), 
        ],
      ),
    );
  }
}