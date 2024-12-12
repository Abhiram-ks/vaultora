import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/helpers/addfunction.dart';

import '../../../db/helpers/categoryfunction.dart';
import '../../common/snackbar.dart';
import '../../records/product/product_records/subfiles_product_reocrd/check_out.dart';

class EditBottomSheet extends StatefulWidget {
  final String id;
  final String imagePath;
  final String categoryName;

  const EditBottomSheet({
    super.key,
    required this.id,
    required this.imagePath,
    required this.categoryName,
  });

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController categoryController;
  final ValueNotifier<ImageData> _imageNotifier = ValueNotifier<ImageData>(
    ImageData(webImageBytes: null, imagePath: null, pickedFile: null),
  );

  final ValueNotifier<String> selectedImagePath = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.categoryName);
    _imageNotifier.value = ImageData(
      webImageBytes: null,
      imagePath: widget.imagePath,
      pickedFile: null,
    );
    selectedImagePath.value = widget.imagePath;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          final webImage = await pickedFile.readAsBytes();
          _imageNotifier.value = ImageData(
            webImageBytes: webImage,
            imagePath: null,
            pickedFile: pickedFile,
          );
          selectedImagePath.value = base64Encode(webImage);
        } else {
          _imageNotifier.value = ImageData(
            webImageBytes: null,
            imagePath: pickedFile.path,
            pickedFile: pickedFile,
          );
          selectedImagePath.value = pickedFile.path;
        }
      } else {
        CustomSnackBarCustomisation.show(
          context: context,
          message: "Please select an image to proceed",
          messageColor: orange,
          icon: Icons.image_search_sharp,
          iconColor: orange,
        );
      }
    } catch (e) {
      CustomSnackBarCustomisation.show(
        context: context,
        message: "Image Selection Error",
        messageColor: redColor,
        icon: Icons.image_not_supported_rounded,
        iconColor: redColor,
      );
    }
  }

  Future<void> updateCategoryInDB() async {
    await initCategoryDB();
    await initAddDB();

    String updatedCategoryName = categoryController.text.trim();
    String updatedImagePath = selectedImagePath.value;

    bool isUsedInName =
        addBox!.values.any((item) => item.dropDown == widget.categoryName);

    if (isUsedInName) {
      CustomSnackBarCustomisation.show(
        context: context,
        icon: Icons.warning,
        iconColor: redColor,
        message: 'Cannot update category as it is in use.',
        messageColor: redColor,
      );
      return;
    }

    bool success = await updateCategory(
      id: widget.id,
      categoryName: updatedCategoryName,
      imagePath: updatedImagePath,
    );

    if (success) {
      CustomSnackBarCustomisation.show(
        context: context,
        message: "Category updated successfully.",
        messageColor: green,
        icon: Icons.cloud_done_outlined,
        iconColor: green,
      );
    } else {
      CustomSnackBarCustomisation.show(
        context: context,
        message: "Failed to update category!",
        messageColor: redColor,
        icon: Icons.warning,
        iconColor: redColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        height: screenHeight * 0.6,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                whiteColor,
                inside,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.004),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 80.0,
                      height: 2.0,
                      color: inside,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                    child: Container(
                      decoration: BoxDecoration(
                        color: transParent,
                        border: Border.all(
                          color: grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          hintText: 'Enter category name',
                          prefixIcon: Icon(Icons.edit_calendar_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                        'assets/gif/welcome 2.json',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.4,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Animation not found');
                        },
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Center(
                            child: ClipOval(
                              child: ValueListenableBuilder<String>(
                                valueListenable: selectedImagePath,
                                builder: (context, value, child) {
                                  if (widget.imagePath.isNotEmpty &&
                                      value.isNotEmpty) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: whiteColor),
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: kIsWeb
                                              ? MemoryImage(base64Decode(value))
                                              : FileImage(File(value))
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: whiteColor),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(
                                        Icons.image_outlined,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: CheckOut(
                      hintText: 'Update Category',
                      height: screenHeight * 0.06,
                      color: black,
                      onTap: () async {
                        await updateCategoryInDB();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
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
