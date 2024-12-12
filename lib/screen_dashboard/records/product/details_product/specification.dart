import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/details_product/subfiles_details/actionbuttons_specification.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/details_product/subfiles_details/delete_edit.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/edit_product/edit_product.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/details_product/subfiles_details/stock_level.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/details_product/subfiles_details/textspecification.dart';

import '../../../../db/helpers/addfunction.dart';
import 'subfiles_details/category_specification.dart';

class Specification extends StatefulWidget {
  final AddModel item;
  const Specification({super.key, required this.item});

  @override
  State<Specification> createState() => _SpecificationState();
}

class _SpecificationState extends State<Specification> {
  @override
  void initState() {
    super.initState();
    initAddDB().then((_) => loadCurrentiteam());
  }

  Future<void> loadCurrentiteam() async {
    await initAddDB();
    final item = addBox!.get(widget.item.id);

    if (item != null) {
      currentiteamNotifier.value = item;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ValueListenableBuilder<AddModel?>(
      valueListenable: currentiteamNotifier,
      builder: (context, value, _) {
        if (value == null || value.id != widget.item.id) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: whiteColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: inside,
                expandedHeight: 250.0,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        inside,
                        whiteColor,
                      ],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 121, 121, 121),
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
                                backgroundColor: transParent,
                                child: PinchToZoomScrollableWidget(
                                  child: ClipOval(
                                    child: widget.item.imagePath.isNotEmpty
                                        ? (kIsWeb ? Image.memory(   base64Decode(value.imagePath),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        ): Image.file(
                                          File(value.imagePath),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ) 
                                        ):Image.asset(
                                           'assets/category/file.png',
                                            fit: BoxFit.cover,
                                             width: double.infinity,
                                            height: double.infinity,
                                          )
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
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        whiteColor,
                        whiteColor,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.04),
                        TextFormSpecificationtwo(
                          text: value.itemName,
                        ),
                        SizedBox(height: screenHeight * 0.006),
                        TextFormSpecificationtwo(
                            text: '₹ ${value.purchaseRate}'),
                        SizedBox(height: screenHeight * 0.008),
                        SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.1,
                          child: SingleChildScrollView(
                            child: CustomReadMoreText(
                              text: value.description,
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
                              text: value.itemCount.toString(),
                              width: screenWidth * 0.24,
                            ),
                          ],
                        ),
                        CategorySpecification(
                          volume: value.dropDown,
                        ),
                        Row(
                          children: [
                            ActionbuttonsSpecification(
                              icon: Icons.delete_outline_outlined,
                              iconColor: redColor,
                              onPressed: () async {
                                bool? confirmDeletion =
                                    await DeleteConfirmationBottomSheet.show(
                                  context,
                                  widget.item.itemName,
                                );
                                if (confirmDeletion == true) {
                                  await deleteItem(widget.item.id, context);
                                }
                              },
                            ),
                            ActionbuttonsSpecification(
                              icon: Icons.edit_calendar_outlined,
                              iconColor: grey,
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: transParent,
                                    builder: (BuildContext context) {
                                      return CustomBottomSheet(
                                          item: widget.item);
                                    });
                              },
                            ),
                            ActionbuttonsSpecificationText(
                              borderColor: inside,
                              text: '₹ ${value.mrp}',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
