import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/main%20page/home/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{



  @override
  Widget build(BuildContext context) {
      int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
    final List<Map<String, dynamic>> revenueData = [
    {
      "title": "Revenue",
      "subtitle": "PROFIT TRACKER: MONITORING YOUR GAINS",
      "description": "Total Revenue",
      "percentage": "+4%",
      "amount": "₹ 3,522,400",
      "color": Colors.green,
      "image": 'assets/illustration.png', // Example image path
    },
    // Add more items if needed
  ];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 29, 66, 77),
            expandedHeight: screenHeight * 0.17,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeAppbar(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                   padding: EdgeInsets.all(screenWidth * 0.04),
                   
                   ),
              ],
            ),

          )
        ],
      ),
    );
  }
}
