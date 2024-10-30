import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/db/models/user.dart';
import 'package:vaultora_inventory_app/main%20page/bottomnavBar/bottomnav.dart';
import 'stackBackgroud/background_stack.dart';
import 'add/add_page.dart';
import 'category/category_page.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';
import 'shop/shop_page.dart';

class Homepage extends StatefulWidget {
  final UserModel userdetails;
  const Homepage({super.key, required this.userdetails});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ShoppingCart(),
    const AddPage(),
    const CategoryPage(),
    const ProfilePage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         const BackgroundStack(),
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Bottomnav(
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
