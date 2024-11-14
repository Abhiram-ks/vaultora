import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltaringPrice extends StatelessWidget {
  final String label;

  const FiltaringPrice({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          fontSize: 15,
          color: const Color.fromARGB(221, 105, 105, 105),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 29, 66, 77),
            fontSize: 15
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SwipeHint extends StatelessWidget {
  const SwipeHint({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.only(right: 12.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Swipe -->',
          style: TextStyle(color: Color.fromARGB(255, 159, 159, 159),fontSize: 14),
        ),
      ),
    );
  }
}