import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import '../../../db/helpers/categoryfunction.dart';
import '../../common/snackbar.dart';

class CategoryBox {
  static final TextEditingController categoryNameController =
      TextEditingController();

  static void showAddCategoryDialog(BuildContext context, String userId) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    XFile? selectedImage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: black,
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
                                  decoration: InputDecoration(
                                    labelText: 'Category Name',
                                    labelStyle: TextStyle(
                                      color: inside,
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
                              backgroundColor: grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              categoryNameController.clear();
                              selectedImage = null;
                              Navigator.of(context).pop();
                            },
                            child:  Text('Cancel',
                                style: TextStyle(color:whiteColor)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final categoryName = categoryNameController.text;
                              final imagePath = selectedImage?.path;

                              if (imagePath == null) {
                                  CustomSnackBarCustomisation.show(
                                    context: context,
                                    message: "Please select an image.",
                                    messageColor:blue,
                                    icon: Icons.image_search_rounded,
                                    iconColor:blue);
                                return;
                              }
                              bool isSuccess = await addCategory(
                                id: DateTime.now().toString(),
                                userid: userId,
                                categoryName: categoryName,
                                imagePath: imagePath,
                              );

                              if (isSuccess) {
                                CustomSnackBarCustomisation.show(
                                    context: context,
                                    message: "Category added successfully.",
                                    messageColor: green,
                                    icon: Icons.cloud_done_outlined,
                                    iconColor: green);
                                categoryNameController.clear();
                                Navigator.of(context).pop();
                              } else {
                                  CustomSnackBarCustomisation.show(
                                    context: context,
                                    message: "Failed to add category. Please try again. !",
                                    messageColor: redColor,
                                    icon: Icons.warning,
                                    iconColor: redColor);
                              }
                            }
                          },
                          child:  Text('Confirm',
                              style: TextStyle(color: whiteColor)),
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
