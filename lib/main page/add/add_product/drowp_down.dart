import 'package:flutter/material.dart';
import 'dart:ui'; 

class DropDown extends StatefulWidget {
  final String hintText;
  final double height;

  const DropDown({
    super.key,
    required this.hintText,
    required this.height,
  });

  @override
  State<DropDown> createState() => _FieldDecorationState();
}

class _FieldDecorationState extends State<DropDown> {
  String? _selectedItem;

  final List<String> _items = [
    'Earphone',
    'Over Head',
    'Neck Band',
    'Earbuds',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: DropdownButtonFormField<String>(
            value: _selectedItem,
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color.fromARGB(96, 94, 94, 94),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            items: _items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            selectedItemBuilder: (BuildContext context) {
              return _items.map<Widget>((String value) {
                return Text(
                  value,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 27, 75, 129), 
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
