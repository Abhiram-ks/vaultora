import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/screen_dashboard/common/snackbar.dart';

import '../../../db/helpers/categoryfunction.dart';

class AddCategoryDialog extends StatefulWidget {
  final String userId;

  const AddCategoryDialog({super.key, required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController categoryNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<ImageData> _imageNotifier = ValueNotifier<ImageData>(
    ImageData(
      webImageBytes: null,
      imagePath: null,
      pickedFile: null,
    ),
  );

  Future<void> _addCategory() async {
    if (formKey.currentState!.validate()) {
      final categoryName = categoryNameController.text;
      String? imagePath;
      final imageData = _imageNotifier.value;
      if (kIsWeb && imageData.webImageBytes != null) {
        imagePath = base64Encode(imageData.webImageBytes!);
      } else if (!kIsWeb && imageData.imagePath != null) {
        imagePath = imageData.imagePath;
      }

      if (imagePath == null) {
        CustomSnackBarCustomisation.show(
            context: context,
            message: "Please select an image to proceed",
            messageColor: orange,
            icon: Icons.photo_size_select_large_rounded,
            iconColor: orange);
        return;
      }

      bool isSuccess = await addCategory(
        id: DateTime.now().toString(),
        userid: widget.userId,
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
            message: "Failed ! Please try again!",
            messageColor: redColor,
            icon: Icons.warning,
            iconColor: redColor);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
          source: ImageSource.gallery, maxWidth: 500, imageQuality: 80);

      if (pickedFile != null) {
        if (kIsWeb) {
          final webImage = await pickedFile.readAsBytes();
          _imageNotifier.value = ImageData(
              webImageBytes: webImage, imagePath: null, pickedFile: pickedFile);
        } else {
          _imageNotifier.value = ImageData(
              webImageBytes: null,
              imagePath: pickedFile.path,
              pickedFile: pickedFile);
        }
      } else {
        CustomSnackBarCustomisation.show(
            context: context,
            message: "Please select an image to proceed",
            messageColor: orange,
            icon: Icons.image_search_sharp,
            iconColor: orange);
      }
    } catch (e) {
      CustomSnackBarCustomisation.show(
          context: context,
          message: "Image Selection Error",
          messageColor: redColor,
          icon: Icons.image_not_supported_rounded,
          iconColor: redColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
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
              ValueListenableBuilder<ImageData>(
                valueListenable: _imageNotifier,
                builder: (context, imageData, child) {
                  return GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: imageData.webImageBytes != null
                              ? MemoryImage(imageData.webImageBytes!)
                              : (imageData.imagePath != null
                                  ? FileImage(File(imageData.imagePath!))
                                  : null),
                          backgroundColor: Colors.grey[300],
                        ),
                        if (imageData.webImageBytes == null &&
                            imageData.imagePath == null)
                          Lottie.asset(
                            'assets/category/addimage.json',
                            fit: BoxFit.contain,
                            width: 90,
                            height:90
                          ),
                      ],
                    ),
                  );
                },
              ),  const SizedBox(height: 10),
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
                    ), const Divider(),
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
                        _imageNotifier.value = ImageData(
                          webImageBytes: null,
                          imagePath: null,
                          pickedFile: null,
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _addCategory,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ImageData {
  final Uint8List? webImageBytes;
  final String? imagePath;
  final XFile? pickedFile;

  ImageData({
    required this.webImageBytes,
    required this.imagePath,
    required this.pickedFile,
  });
}
