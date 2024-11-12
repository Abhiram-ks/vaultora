import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';

class ScreenColor {
  final List<Color> colors;
 
  ScreenColor({required this.colors,});
  BoxDecoration get gradientDecoration {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
class OrCall extends StatelessWidget {
   final String text;
  const OrCall({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 10.0),
      child:  Row(
        children: [
           Expanded(
            child: Divider(
              thickness: 1,
              color:greyColor,
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), 
            child: Text(
              text,
              style:const TextStyle(color: Color.fromARGB(255, 165, 165, 165), fontWeight: FontWeight.bold),
            ),
          ),
           Expanded(
            child: Divider(
              thickness: 1,
               color:greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
