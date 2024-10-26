import 'package:flutter/material.dart';

class BackgroundStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: const Color(0xFFE8EDEB),
          ),
        ),
        
        Positioned(
          top: MediaQuery.of(context).size.height * 0.3,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: BottomAngleClipper(),
            child: Container(
              color: Colors.lightGreen.shade100,
              height: MediaQuery.of(context).size.height * 0.3, 
            ),
          ),
        ),
      ],
    );
  }
}

class BottomAngleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30); 
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0); 
    path.close(); 
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
