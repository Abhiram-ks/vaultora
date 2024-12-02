import 'package:flutter/material.dart';
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
      appBar:const MyAppBarTwo(titleText: 'Revanue'),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.01,),
                RevanueContainer(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  ),
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
                          Icons.lightbulb_outline,
                          color: Colors.yellow,
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


class RevanueContainer extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const RevanueContainer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: double.infinity,
      height: screenHeight * 0.07,
    );
  }
}
