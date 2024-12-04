import 'package:flutter/material.dart';
import 'dart:io';

import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class AddStyle extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onSwipe;
  final String titleText;
  final String descriptionText;
  final String buttonText;
  final String imagePath;

  const AddStyle({
    super.key,
    this.onTap,
    this.onSwipe,
    required this.titleText,
    required this.descriptionText,
    required this.buttonText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      onHorizontalDragEnd: (details) {
        if (onSwipe != null) onSwipe!();
      },
      child: PinchToZoomScrollableWidget(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: const Color(0xFFE8EDEB),
            width: double.infinity,
            height: screenHeight * 0.181,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.shopping_bag_rounded, color: black),
                        ),
                      ),
                      ClipOval(
                        child: Container(
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            image: DecorationImage(
                              image: imagePath.isNotEmpty
                                  ? FileImage(File(imagePath)) as ImageProvider
                                  : const AssetImage(
                                      'assets/welcome/main image.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Material(
                        shadowColor: black,
                        elevation: 10,
                        child: Container(
                          height: screenHeight * 0.2,
                          color: whiteColor,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titleText,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                descriptionText,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 95, 95, 95),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 196, 196, 196),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  buttonText,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
