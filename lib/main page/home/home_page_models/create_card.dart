import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String categoryId;
  final VoidCallback onDelete;
  final Color backgroundColor;
  final VoidCallback onEdit;

  const CreateCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.categoryId,
    required this.onDelete,
    required this.backgroundColor,
    required this.onEdit,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: widget.backgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: widget.imagePath.isNotEmpty
                    ? FileImage(File(widget.imagePath)) as ImageProvider
                    : const AssetImage('assets/category/file.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              widget.title,
              style: GoogleFonts.kodchasan(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 1,
            child: PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert, color: Colors.white, size: 19),
              onSelected: (value) {
                if (value == 1) {
                  widget.onDelete();
                } else if (value == 2) {
                  widget.onEdit();
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Delete'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('Edit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
