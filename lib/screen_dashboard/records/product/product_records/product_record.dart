import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/filtering_product/filter_price.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/filtering_product/searchbar.dart';
import '../../../../db/helpers/addfunction.dart';
import 'subfiles_product_reocrd/add_style.dart';
import '../../../common/appbar.dart';
import '../details_product/specification.dart';
import '../filtering_product/clear_filter.dart';

class PurchaseRecord extends StatefulWidget {
  const PurchaseRecord({super.key});

  @override
  State<PurchaseRecord> createState() => _PurchaseRecordState();
}

class _PurchaseRecordState extends State<PurchaseRecord> {
  bool _isFilterVisible = false;

  void _toggleFilter() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _closeFilter() {
    if (_isFilterVisible) {
      setState(() {
        _isFilterVisible = false;
      });
    }
  }

  void _showClearFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return ClearFilterBottomSheet(
          onClear: () {
            Navigator.pop(context);
            addListNotifier.value = List.from(originalItemList);
            // ignore: invalid_use_of_protected_member
            addListNotifier.notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Filters Cleared')),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  MyAppBarTwo(titleText: 'Inventory Record',bgColor: inside,),
      body: GestureDetector(
        onTap: _closeFilter,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Searchbarmain(
                    hintText: 'Search for Items',
                    onSearchPressed: () {},
                    onFilterPressed: _toggleFilter,
                    isFilterActive: _isFilterVisible,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: ValueListenableBuilder<List<AddModel>>(
                      valueListenable: addListNotifier,
                      builder: (context, addList, child) {
                        if (addList.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/gif/purchase_empty.json',
                                  width: screenWidth * 0.5,
                                  height: screenHeight * 0.3,
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'No records found !',
                                  style: GoogleFonts.kodchasan(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 129, 129, 129),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: addList.length,
                            itemBuilder: (context, index) {
                              final item = addList[index];
                              return Column(
                                children: [
                                  AddStyle(
                                    imagePath: item.imagePath,
                                    titleText: item.itemName,
                                    descriptionText: item.description,
                                    buttonText: item.dropDown,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Specification(item: item),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_isFilterVisible)
              FilterDropdown(
                onClose: () => setState(() => _isFilterVisible = false),
                onClearFilters: _showClearFilterSheet,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
          ],
        ),
      ),
    );
  }
}
