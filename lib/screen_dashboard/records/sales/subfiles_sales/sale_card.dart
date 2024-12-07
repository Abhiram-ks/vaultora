import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String itemName;
  final String price;
  final String shopValue1;
  final String shopValue2;
  final String shopValue3;

  const CustomCard({
    super.key,
    required this.title,
    required this.itemName,
    required this.price,
    required this.shopValue1,
    required this.shopValue2,
    required this.shopValue3,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Card(
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: const Color(0xFFE8EDEB),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.01,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.headphones),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              title,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.02),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          itemName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 11, 11, 11),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.02),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons
                                                .playlist_add_circle_sharp),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                price,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.shopify_sharp,
                                size: 33,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(shopValue1,
                                      style: const TextStyle(fontSize: 10)),
                                  Text(shopValue2,
                                      style: const TextStyle(fontSize: 10)),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.1),
                                    child: const Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  Text(shopValue3,
                                      style: const TextStyle(fontSize: 10)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 7,
          left: 7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen, 
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.shopping_bag, 
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}