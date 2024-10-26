import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/stackBackgroud/background_stack.dart';

class addProduct extends StatefulWidget {
  const addProduct({super.key});

  @override
  State<addProduct> createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Stack(
        children: [
          BackgroundStack(), 
        ],
      ),
    );
  }
}