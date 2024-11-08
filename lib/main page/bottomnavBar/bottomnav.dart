import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bottomnav extends StatefulWidget {
  final Function(int) onTap;

  const Bottomnav({super.key, required this.onTap});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedIndex = 0;

  void bottomnavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });

    widget.onTap(index);

    String message;
    switch (index) {
      case 0:
        message = 'Home';
        break;
      case 1:
        message = 'Shopping Cart';
        break;
      case 2:
        message = 'Add';
        break;
      case 3:
        message = 'Category';
        break;
      case 4:
        message = 'Profile';
        break;
      default:
        message = '';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: DefaultTextStyle(
          style: const TextStyle(color: Colors.black),
          child: Text(message),
        ),
        duration: const Duration(milliseconds: 300),
        backgroundColor: Colors.black.withOpacity(0.0),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: const Color.fromARGB(255, 29, 66, 77),
      buttonBackgroundColor: const Color.fromARGB(255, 29, 66, 77),
      height: 60,
      index: _selectedIndex,
      onTap: bottomnavBar,
      items: <Widget>[
        FaIcon(
          FontAwesomeIcons.house,
          size: 24,
          color: _selectedIndex == 0 ? Colors.white : const Color.fromARGB(255, 159, 159, 159),
        ),
        FaIcon(
          FontAwesomeIcons.cartShopping,
          size: 24, 
          color: _selectedIndex == 1 ? Colors.white : const Color.fromARGB(255, 159, 159, 159),
        ),
        FaIcon(
          FontAwesomeIcons.plus,
          size: 30, 
          color: _selectedIndex == 2 ? Colors.white : const Color.fromARGB(255, 159, 159, 159),
        ),
        FaIcon(
          FontAwesomeIcons.clipboardList,
          size: 25,
          color: _selectedIndex == 3 ? Colors.white : const Color.fromARGB(255, 159, 159, 159),
        ),
        FaIcon(
          FontAwesomeIcons.solidUser,
          size: 24, 
          color: _selectedIndex == 4 ? Colors.white : const Color.fromARGB(255, 159, 159, 159),
        ),
      ],
    );
  }
}
