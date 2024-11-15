import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../db/functions/categoryfunction.dart';
import '../../../db/models/category/catalog.dart'; 

class DropDown extends StatelessWidget {
  final String hintText;
  final double height;
  final ValueNotifier<String?> selectedCategoryNotifier;

  const DropDown({
    super.key,
    required this.hintText,
    required this.height,
    required this.selectedCategoryNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CategoryModel>>(
      valueListenable: categoryListNotifier,
      builder: (context, categoryList, child) {
        if (categoryList.isEmpty) {
          return const CircularProgressIndicator();
        }
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent, 
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey), 
          ),
          child: DropdownButtonFormField<String>(
            value: selectedCategoryNotifier.value,
            onChanged: (String? newValue) {
              selectedCategoryNotifier.value = newValue;
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none, 
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            items: categoryList.map<DropdownMenuItem<String>>((CategoryModel category) {
              return DropdownMenuItem<String>(
                value: category.categoryName,
                child: Text(category.categoryName),
              );
            }).toList(),
            dropdownColor: Colors.white, 
          ),
        );
      },
    );
  }
}
