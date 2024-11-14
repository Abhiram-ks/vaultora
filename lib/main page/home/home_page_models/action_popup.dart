import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../db/functions/categoryfunction.dart';

void showDeleteConfirmation(BuildContext context, String categoryId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await deleteCategory(categoryId);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Delete', style: TextStyle(
                color: Colors.white,
              ),),
          ),
        ],
      );
    },
  );
}


 
void showEditConfirmation(
    BuildContext context, String id, String imagePath, String categoryName) {
  TextEditingController categoryController = TextEditingController(text: categoryName);
  ValueNotifier<String> selectedImagePath = ValueNotifier<String>(imagePath);

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> updateCategoryInDB() async {
    String updatedCategoryName = categoryController.text;
    String updatedImagePath = selectedImagePath.value;

    bool success = await updateCategory(
      id: id,
      categoryName: updatedCategoryName,
      imagePath: updatedImagePath,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Category updated successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Failed to update category.')),
      );
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                pickImage(); 
              },
              child: Center(
                child: ClipOval(
                  child: ValueListenableBuilder<String>(
                    valueListenable: selectedImagePath,
                    builder: (context, value, child) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: value.isNotEmpty
                                ? FileImage(File(value)) as ImageProvider
                                : const AssetImage('assets/category/file.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
           const SizedBox(height: 10),
            Row(
              children: [
               const Icon(Icons.edit_calendar_rounded),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      hintText: 'Enter category name',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await updateCategoryInDB();
              Navigator.of(context).pop(); 
            }, style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              ' Update',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
