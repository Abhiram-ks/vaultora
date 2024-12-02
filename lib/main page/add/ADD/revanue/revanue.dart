import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/ADD/revanue/revanue_sub/revanue_contaier.dart';
import 'package:vaultora_inventory_app/main%20page/add/productfiles_sub/appbar.dart';

class RevanuePage extends StatefulWidget {
  const RevanuePage({super.key});

  @override
  State<RevanuePage> createState() => _RevanuePageState();
}

class _RevanuePageState extends State<RevanuePage> {
  bool _isIconDisabled = false;
  bool _showTutorial = true;

  @override
  void dispose() {
    super.dispose();
  }

void _onIconPressed() {
  if (mounted) {
    setState(() {
      _isIconDisabled = true;
      _showTutorial = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBarTwo(titleText: 'Revanue'),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                RevanueContainer(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.5,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.025,
                    mainAxisSpacing: screenHeight * 0.015,
                    children: [
                     RevenueDetailsContainer(
  gradient: LinearGradient(
    colors: [const Color.fromARGB(255, 30, 104, 32), const Color.fromARGB(255, 184, 255, 186)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  screenHeight: MediaQuery.of(context).size.height,
  screenWidth: MediaQuery.of(context).size.width,
  title: 'Total Sales',
  icon: Icons.attach_money,
  salesText: '₹24780.00',
   iconColor: const Color.fromARGB(255, 160, 196, 139), 
),

                     RevenueDetailsContainer(
  gradient: LinearGradient(
    colors: [const Color.fromARGB(255, 14, 72, 119), const Color.fromARGB(255, 160, 212, 255)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  screenHeight: MediaQuery.of(context).size.height,
  screenWidth: MediaQuery.of(context).size.width,
  title: 'Remaning Value',
  icon: Icons.shopping_basket,
  salesText: '₹54780.00',
   iconColor: const Color.fromARGB(255, 118, 171, 215), 
),
                     RevenueDetailsContainer(
  gradient: LinearGradient(
     colors: [Colors.orange, const Color.fromARGB(255, 255, 220, 164)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  screenHeight: MediaQuery.of(context).size.height,
  screenWidth: MediaQuery.of(context).size.width,
    title: 'Total Product',
  icon: Icons.assignment_turned_in,
  salesText: '9',
   iconColor: const Color.fromARGB(255, 255, 225, 181), 
),
                      RevenueDetailsContainer(
  gradient: LinearGradient(
    colors: [Colors.purple,const Color.fromARGB(255, 245, 186, 255),],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  screenHeight: MediaQuery.of(context).size.height,
  screenWidth: MediaQuery.of(context).size.width,
  title: 'Total Customers',
  icon: Icons.people,
  salesText: '30',
   iconColor: const Color.fromARGB(255, 248, 181, 255), 
),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (_showTutorial)
            GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _showTutorial = false;
                  });
                }
              },
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tap this button to see inventory details!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                        heroTag: "tutorial_button",
                        onPressed: _onIconPressed,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: const Icon(
                          Icons.bar_chart_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "main_button",
        onPressed: _onIconPressed,
        backgroundColor: Colors.white,
        child: Icon(
          _isIconDisabled ? Icons.pie_chart_rounded : Icons.bar_chart_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
class RevenueDetailsContainer extends StatelessWidget {
  final Gradient gradient;
  final double screenHeight;
  final double screenWidth;
  final IconData icon;
   final Color iconColor; 
  final String salesText;
  final String title;

  const RevenueDetailsContainer({
    super.key,
    required this.gradient,
    required this.screenHeight,
    required this.screenWidth,
    required this.icon,
     required this.iconColor,
    required this.salesText,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
          ),
          width: screenWidth / 2,
          height: screenHeight * 0.2,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  salesText, 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 1,
          right: 0,
          child: Icon(
            icon,
             color: iconColor, 
            size: 70,
          ),
        ),
      ],
    );
  }
}
