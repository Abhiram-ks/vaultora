import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/actionbuttons_specification.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/category_specification.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/delete_edit.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/edit_product.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/stock_level.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/detailPurchase/textspecification.dart';

import '../../../../db/functions/addfunction.dart';
import '../../../../db/models/add/add.dart';


class Specification extends StatefulWidget {
  final AddModel item;
  const Specification({super.key, required this.item});

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
                            child: widget.item.imagePath.isNotEmpty
                                ? Image.file(
                                    File(widget.item.imagePath),
                                    fit: BoxFit.cover,
                                    width: screenWidth * 0.27,
                                    height: screenWidth * 0.27,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  )
                                : Image.asset(
                                    'assets/welcome/main image.jpg',
                                    fit: BoxFit.cover,
                                    width: screenWidth * 0.27,
                                    height: screenWidth * 0.27,
                                  ),
                          ),
                        ),
                      ),
                    )
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
                  TextFormSpecificationtwo(
                    text: widget.item.itemName,
                  ),
                  SizedBox(height: screenHeight * 0.006),
                  TextFormSpecificationtwo(
                      text: '₹ ${widget.item.purchaseRate}'),
                  SizedBox(height: screenHeight * 0.008),
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.1,
                    child: SingleChildScrollView(
                      child: CustomReadMoreText(
                        text: widget.item.description,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      StockLevel(
                        text: 'Stock Level',
                        width: screenWidth * 0.34,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      StockLevel(
                        text: widget.item.itemCount,
                        width: screenWidth * 0.24,
                      ),
                    ],
                  ),
                  CategorySpecification(
                    volume: widget.item.dropDown,
                  ),
                  Row(
                    children: [
                      ActionbuttonsSpecification(
                        icon: Icons.delete_outline_outlined,
                        iconColor: const Color.fromARGB(255, 188, 38, 27),
                        onPressed: () async {
                          bool? confirmDeletion =
                              await DeleteConfirmationDialog.show(context);

                          if (confirmDeletion == true) {
                            deleteItem(widget.item.id);
                          }
                        },
                      ),
                      ActionbuttonsSpecification(
                        icon: Icons.edit_calendar_outlined,
                        iconColor: Colors.grey,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return CustomBottomSheet(item: widget.item);
                              });
                        },
                      ),
                      ActionbuttonsSpecificationText(
                        borderColor: const Color.fromARGB(255, 29, 66, 77),
                        text: '₹ ${widget.item.mrp}',
                      )
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

