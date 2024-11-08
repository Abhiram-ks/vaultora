import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';

class PageviewBuilder extends StatelessWidget {
  final PageController pageController;
  final int itemCount;
  final List<Map<String, dynamic>> pageData;

  const PageviewBuilder({
    super.key,
    required this.pageController,
    required this.itemCount,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: PageView.builder(
        controller: pageController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final data = pageData[index];
          return Container(
            width: double.infinity,
            color: data['color'],
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    data['image'],
                    fit: BoxFit.cover,
                    height: screenHeight / 4,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.75),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                )),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (data.containsKey('subtitle'))
                        Text(
                          data['subtitle'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      if (data.containsKey('subtitle2'))
                        Text(
                          data['subtitle2'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      if (data.containsKey('subtitle3'))
                        Text(
                          data['subtitle3'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      if (data.containsKey('subtitle4'))
                        Text(
                          data['subtitle4'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color color;

  const CustomCard({super.key, required this.imagePath, required this.title,required this.color});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color:color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth * 0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: screenWidth * 0.41,
                height: screenWidth * 0.41, 
              ),
            ),
             Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                      
                        Colors.black.withOpacity(0.0),
                         Colors.black.withOpacity(0.60),
                         
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                title,
                style: GoogleFonts.kodchasan(
                  fontSize: 20,
                  color: textColor2,
     
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}