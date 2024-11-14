import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/actionbuttons_specification.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/category_specification.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/stock_level.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/textspecification.dart';

class Specification extends StatefulWidget {
  const Specification({super.key});

  @override
  State<Specification> createState() => _SpecificationState();
}

class _SpecificationState extends State<Specification> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 29, 66, 77),
            expandedHeight: 250.0,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const TextFormSpecification(text: 'Specification'),
                  ],
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16.0, top: 16.0),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset(
                      'assets/gif/welcome 2.json',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.4,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Animation not found');
                      },
                    ),
                    Positioned(
                      child: SizedBox(
                        width: screenWidth * 0.27,
                        height: screenWidth * 0.27,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/liquid/Timeline-bro.png',
                              fit: BoxFit.cover,
                              width: screenWidth * 0.27,
                              height: screenWidth * 0.27,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
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
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                  const TextFormSpecificationtwo(text: 'Sony WH - CH520'),
                  SizedBox(height: screenHeight * 0.006),
                  const TextFormSpecificationtwo(text: '₹ 900000'),
                  SizedBox(height: screenHeight * 0.008),
                 Container(
                 width:  double.infinity,
                 height: screenHeight * 0.1,
                 child: SingleChildScrollView(
                   child: const CustomReadMoreText(
                      text: 'Information about customer buying habits, including items, quantity, and price. '
                            'Detailed analysis helps in understanding customer preferences and purchasing patterns, '
                            'allowing for more tailored marketing strategies and inventory management.',
                    ),
                 ),
                 ),
                 Row(
                   children: [
                     StockLevel(
                      text: 'Stock Level',
                      width: screenWidth*0.34,
                     ),
                     SizedBox(width: screenWidth * 0.04),
                         StockLevel(
                  text: '67',
                  width: screenWidth*0.24,
                 ),
                   ],
                 ),
              
                 CategorySpecification(
                  volume: 'HEADSETS ',
                 ),
                 Row(
                   children: [
                     ActionbuttonsSpecification(
                      icon: Icons.delete_outline_outlined,
                      iconColor: Colors.red,
                       onPressed: () {
                         print("Delete button tapped");
                       },
                     ),
                      ActionbuttonsSpecification(
                        icon: Icons.edit_calendar_outlined,
                        iconColor: Colors.grey,
                       onPressed: () {
                         print("Delete button tapped");
                       },
                     ),
                     ActionbuttonsSpecificationText(borderColor: const Color.fromARGB(255, 216, 132, 6),
                     text: '₹ 789809', )
                   ],
                 ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
