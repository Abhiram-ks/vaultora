import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../db/functions/categoryfunction.dart';

class CategoryBox {
  static final TextEditingController categoryNameController =
      TextEditingController();

  static void showAddCategoryDialog(BuildContext context, String userId) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    XFile? selectedImage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        selectedImage =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (selectedImage != null) {
                          setState(() {});
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          color: const Color.fromARGB(255, 224, 224, 224),
                          child: selectedImage != null
                              ? Image.file(
                                  File(selectedImage!.path),
                                  width: screenWidth * 0.34,
                                  height: screenHeight * 0.15,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.add_photo_alternate_sharp,
                                  size: 50,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.category_sharp, size: 28),
                              SizedBox(width: screenWidth * 0.05),
                              Flexible(
                                child: TextFormField(
                                  controller: categoryNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Category Name',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 29, 66, 77),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Category Name cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              categoryNameController.clear();
                              selectedImage = null;
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final categoryName = categoryNameController.text;
                          final imagePath = selectedImage?.path;

                          if (imagePath == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select an image'),
                              ),
                            );
                            return;
                          }
                          bool isSuccess = await addCategory(
                            id: DateTime.now().toString(),
                            userid: userId,
                            categoryName: categoryName,
                            imagePath: imagePath,
                          );

                          if (isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Category added successfully'),
                              ),
                            );
                            categoryNameController.clear();
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to add category. Please try again.'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
