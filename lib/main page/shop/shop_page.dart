import 'package:flutter/material.dart';

import '../stackBackgroud/background_stack.dart';

class shoppingCart extends StatefulWidget {
  const shoppingCart({super.key});

  @override
  State<shoppingCart> createState() => _shoppingCartState();
}

class _shoppingCartState extends State<shoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundStack(), 
        ],
      ),
    );
  }
}