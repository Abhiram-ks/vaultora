import 'package:flutter/material.dart';

import '../../../../db/helpers/addfunction.dart';


class Searchbarmain extends StatefulWidget {
  final String hintText;
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;
  final bool isFilterActive;

  const Searchbarmain({
    super.key,
    required this.hintText,
    required this.onSearchPressed,
    required this.onFilterPressed,
    required this.isFilterActive,
  });

  @override
  State<Searchbarmain> createState() => _SearchbarmainState();
}

class _SearchbarmainState extends State<Searchbarmain> {
  final TextEditingController _controller = TextEditingController();

  void _filterItems(String query) {
    if (query.isEmpty) {
      addListNotifier.value = List.from(originalItemList);
    } else {
      final filteredItems = originalItemList
          .where((item) => item.itemName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      addListNotifier.value = filteredItems;
    }
    // ignore: invalid_use_of_protected_member
    addListNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.07,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _controller,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
            IconButton(
            onPressed: widget.onFilterPressed,
            icon: Icon(
              widget.isFilterActive ? Icons.close : Icons.filter_alt,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF68C5CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.onSearchPressed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



