import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Color/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String animationPath;

  const MyAppBar({
    super.key,
    required this.titleText,
    required this.animationPath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbarColor,
      leading: Lottie.asset(
          animationPath,
          height: 40.0,
          width: 40.0,
        ),
      title: Text(
        titleText,
        style: TextStyle(color: black,fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Color bgColor;

  const  MyAppBarTwo({
    super.key,
    required this.titleText,
    required this.bgColor,
  
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      title: Text(
        titleText,
        style: TextStyle(color: textColor2),
      ),
      iconTheme:  IconThemeData(
        color: whiteColor, 
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAppBarlast extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const  MyAppBarlast({
    super.key,
    required this.titleText,
  
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      title: Text(
        titleText,
        style: TextStyle(color: black),
      ),
      iconTheme:  IconThemeData(
        color: black, 
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}