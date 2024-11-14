import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ActionbuttonsSpecification extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon; 
  final Color iconColor; 

  const ActionbuttonsSpecification({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.05),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: screenHeight * 0.06,
          width: screenWidth * 0.15,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 134, 134, 134),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Icon(
              icon, 
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}


class ActionbuttonsSpecificationText extends StatelessWidget {
  final String text; 
  final Color borderColor; 
  const ActionbuttonsSpecificationText({
    super.key,
    required this.text,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.05),
      child: Container(
        height: screenHeight * 0.06,
        width: screenWidth * 0.35,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(10),
          border:null,
        ),
        alignment: Alignment.center,
        child: Text(
          text, 
          style:const TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
