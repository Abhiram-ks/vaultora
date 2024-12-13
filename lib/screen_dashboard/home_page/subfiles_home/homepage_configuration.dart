
import 'package:flutter/material.dart';

class HomePageConfiguration {
  static final List<Color> cardColors = [
    const Color.fromARGB(255, 29, 66, 77),
    const Color.fromARGB(255, 40, 98, 116),
    const Color.fromARGB(255, 59, 140, 164),
    const Color.fromARGB(255, 125, 185, 203),
    const Color.fromARGB(255, 40, 98, 116),
  ];

  static final List<Map<String, dynamic>> pageData = [
    {
      'image': 'assets/liquid/girl.jpg',
      'title': 'Real-time Tracking',
      'subtitle': 'UPDATES STOCK LEVELS INSTANTLY',
      'subtitle2': 'An Inventory App is a digital tool that helps',
      'subtitle3': 'businesses keep track of their products,',
      'subtitle4': 'stock levels and orders in real-time.',
      'color': const Color.fromARGB(255, 171, 174, 118),
    },
    {
      'image': 'assets/liquid/growth.jpg',
      'title': 'Revenue',
      'subtitle': 'PROFIT TRACKER, MONITORING GAINS',
      'subtitle2': 'Revenue is the total income a business',
      'subtitle3': ' earns from selling goods or services before ',
      'subtitle4': 'any costs or expenses are subtracted.',
      'color': const Color.fromARGB(255, 62, 58, 58),
    },
    {
      'image': 'assets/liquid/manwith headset.jpg',
      'title': 'Universal Language ',
      'subtitle': 'CONNECTS PEOPLE ACROSS CULTURES',
      'subtitle2': 'Music is the art of combining sounds to express emotion,',
      'subtitle3': 'tell stories, and connect people. Its a universal ',
      'subtitle4': 'language that inspires and unites across cultures.',
      'color': Colors.blue[300],
    },
    {
      'image': 'assets/liquid/5363923.jpg',
      'title': 'Stock Management',
      'subtitle': 'MONITORS INVENTORY LEVELS EFFICIENTLY',
      'subtitle2': 'Stock is the supply of goods a business holds to',
      'subtitle3': 'meet customer demand, ensuring smooth',
      'subtitle4': 'operations and preventing shortages.',
      'color': const Color.fromARGB(255, 113, 93, 66),
    },
    {
      'image': 'assets/liquid/happy-girl-singing-favorite-song-listening-music-wireless-headphones-smiling-dancing-standing-pink-background.jpg',
      'title': 'Seamless Experience',
      'subtitle': 'Enjoy the Features of the APP',
      'subtitle2': 'Inventory is the collection of goods a business keeps on',
      'subtitle3': 'hand to fulfill customer needs, supporting efficient ',
      'subtitle4': 'operations and preventing stockouts.',
      'color': const Color.fromARGB(255, 213, 89, 170),
    },
  ];

  // Method to get a card color by index
  static Color getCardColor(int index) {
    return cardColors[index % cardColors.length];
  }

  // Method to get page data
  static List<Map<String, dynamic>> getPageData() {
    return pageData;
  }
}
