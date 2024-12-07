
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class EditStyle extends StatelessWidget {
  final IconData icon; 
  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final String? Function(String? value) validate; 
    final Color dividerColor; 
  final Color textColor; 

  const EditStyle({
    super.key,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    required this.label,
    required this.validate, 
    required this.dividerColor,
    required this.textColor
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
                color: black,
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
                    color:textColor
                  ),
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle:  TextStyle(
                      color: inside,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: dividerColor),
        ],
      ),
    );
  }
}
