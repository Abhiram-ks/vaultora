import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/main%20page/bottomnavBar/bottomnav.dart';
import 'add/add_main/addpage.dart';

import 'category/category_page.dart';
import 'home/home_page.dart';
import 'profile/modification/profile_page.dart';
import 'shop/shop_page.dart';

class Homepage extends StatefulWidget {
 
  const Homepage({super.key, required this.userDetails});
  final UserModel userDetails;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;


  final List<Widget> _pages = [];
  
  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(userDetails: widget.userDetails),
      const ShoppingCart(),
      Addpage(userDetails: widget.userDetails),
      const CategoryPage(),
      ProfilePage(userDetails: widget.userDetails),
    ]);
  }
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
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Bottomnav(
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
