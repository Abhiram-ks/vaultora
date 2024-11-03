import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditStyle extends StatelessWidget {
  final IconData icon; 
  final TextEditingController controller;
  final String label;

  const EditStyle({
    super.key,
    required this.icon,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
               Icon(
                icon,
                size: 28,
              ),
              SizedBox(width: screenWidth*0.05,),
              Flexible(
                child: TextFormField(
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color.fromARGB(221, 105, 105, 105),
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 29, 66, 77),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
