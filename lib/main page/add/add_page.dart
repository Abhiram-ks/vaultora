import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/stackBackgroud/background_stack.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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