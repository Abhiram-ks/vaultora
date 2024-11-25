import 'package:flutter/material.dart';

class DropDownItemName extends StatelessWidget {
  final String hintText;
  final double height;
  final ValueNotifier<String?> selectedItemNotifier;
  final List<String> items;

  const DropDownItemName({
    super.key,
    required this.hintText,
    required this.height,
    required this.selectedItemNotifier,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedItemNotifier.value,
          onChanged: (String? newValue) {
            selectedItemNotifier.value = newValue;
          },
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
