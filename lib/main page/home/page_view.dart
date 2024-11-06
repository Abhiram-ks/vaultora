import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  const CustomCard({required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: const Color.fromARGB(255, 237, 237, 237),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth * 0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10, 
              left: 10, 
              child: Text(
                title,
                style: GoogleFonts.kodchasan(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
