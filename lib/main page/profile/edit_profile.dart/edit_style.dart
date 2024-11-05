
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditStyle extends StatelessWidget {
  final IconData icon; 
  final TextEditingController controller;
   final bool obscureText;
  final String label;
  final String? Function(String? value) validate; 

  const EditStyle({
    super.key,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    required this.label,
    required this.validate, 
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                  controller: controller,
                  obscureText: obscureText,
                  validator: validate,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color.fromARGB(221, 105, 105, 105),
                  ),
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
