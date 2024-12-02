import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/product_record/sub_record_screen/clear_filter.dart';

import '../../../../db/functions/addfunction.dart';
import '../../../../db/functions/categoryfunction.dart';
import '../../../../db/models/add/add.dart';
import '../../../../db/models/category/catalog.dart';

class FilterDropdown extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onClearFilters;
  final double screenWidth;
  final double screenHeight;

  const FilterDropdown({
    super.key,
    required this.onClose,
    required this.onClearFilters,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FilterDropdownState createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  final double _minPrice = 0;
  double _maxPrice = 1000;
  final ValueNotifier<RangeValues> _currentRangeNotifier =
      ValueNotifier(const RangeValues(0, 1000));
  final ValueNotifier<int> _productCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<List<CategoryModel>> _selectedCategoriesNotifier =
      ValueNotifier<List<CategoryModel>>([]);

  @override
  void initState() {
    super.initState();
    _setMaxPrice();
  }

  Future<void> _setMaxPrice() async {
    double maxMRP = await getMaxMRP();
    setState(() {
      _maxPrice = maxMRP;
      _currentRangeNotifier.value = RangeValues(0, _maxPrice);
    });
  }

  void _clearFilters() {
    _currentRangeNotifier.value = RangeValues(_minPrice, _maxPrice);
    _selectedCategoriesNotifier.value = [];
    _productCountNotifier.value = originalItemList.length;
    widget.onClearFilters();
  }

  void _showClearFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ClearFilterBottomSheet(
          onClear: () {
            _clearFilters();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _filterItems(RangeValues range) {
    List<AddModel> filteredItems = originalItemList.where((item) {
      double itemPrice = double.tryParse(item.mrp) ?? 0.0;
      return itemPrice >= range.start && itemPrice <= range.end;
    }).toList();

    setState(() {
      _productCountNotifier.value = filteredItems.length;
    });
  }

  void _toggleCategorySelection(CategoryModel category) {
    List<CategoryModel> selectedCategories =
        List.from(_selectedCategoriesNotifier.value);

    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }

    setState(() {
      _selectedCategoriesNotifier.value = selectedCategories;
    });
  }

  void _applyFilters() {
    final selectedCategories = _selectedCategoriesNotifier.value;
    final priceRange = _currentRangeNotifier.value;
    List<AddModel> filteredItems = originalItemList.where((item) {
      final price = double.tryParse(item.mrp) ?? 0.0;
      final matchesCategory = selectedCategories.isEmpty ||
          selectedCategories
              .any((category) => item.dropDown == category.categoryName);
      final matchesPrice = price >= priceRange.start && price <= priceRange.end;

      return matchesCategory && matchesPrice;
    }).toList();

    setState(() {
      _productCountNotifier.value = filteredItems.length;
      addListNotifier.value = filteredItems;
    });

    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.screenHeight * 0.10 + 10,
      left: widget.screenWidth * 0.03,
      right: widget.screenWidth * 0.03,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filters",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: _showClearFilterBottomSheet,
                        child: const Text("Clear Filters")),
                  ),
                ],
              ),
              SizedBox(height: widget.screenHeight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: GoogleFonts.kodchasan(
                    fontSize: 14,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              ValueListenableBuilder<List<CategoryModel>>(
                valueListenable: categoryListNotifier,
                builder: (context, categoryList, child) {
                  if (categoryList.isEmpty) {
                    return const CircularProgressIndicator();
                  }
                  return ValueListenableBuilder<List<CategoryModel>>(
                    valueListenable: _selectedCategoriesNotifier,
                    builder: (context, selectedCategories, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: widget.screenHeight * 0.05,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length,
                            itemBuilder: (context, index) {
                              final category = categoryList[index];
                              final isSelected =
                                  selectedCategories.contains(category);

                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () =>
                                      _toggleCategorySelection(category),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: isSelected
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : Colors.grey[300],
                                      width: 100,
                                      height: double.infinity,
                                      child: Center(
                                        child: Text(
                                          category.categoryName,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price Range',
                  style: GoogleFonts.kodchasan(
                    fontSize: 14,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              Column(
                children: [
                  ValueListenableBuilder<RangeValues>(
                    valueListenable: _currentRangeNotifier,
                    builder: (context, currentRange, child) {
                      return Column(
                        children: [
                          RangeSlider(
                            values: currentRange,
                            min: _minPrice,
                            max: _maxPrice,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey.withOpacity(0.5),
                            labels: RangeLabels(
                              '₹${currentRange.start.toStringAsFixed(0)}',
                              '₹${currentRange.end.toStringAsFixed(0)}',
                            ),
                            onChanged: (RangeValues values) {
                              _currentRangeNotifier.value = values;
                              _filterItems(values);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${currentRange.start.toStringAsFixed(0)}',
                                style: GoogleFonts.kodchasan(
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              Text(
                                '₹${currentRange.end.toStringAsFixed(0)}',
                                style: GoogleFonts.kodchasan(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: widget.screenHeight * 0.02),
                ],
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: _productCountNotifier,
                          builder: (context, count, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$count'),
                                Text(
                                  'Products found',
                                  style: GoogleFonts.kodchasan(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
