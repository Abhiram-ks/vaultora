import 'package:flutter/material.dart';

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
