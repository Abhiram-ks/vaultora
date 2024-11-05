import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/login/validation/validation.dart';
import 'package:vaultora_inventory_app/main%20page/profile/edit_profile.dart/Edit_style.dart';
import 'package:vaultora_inventory_app/main%20page/profile/modification/profile_page.dart';

import '../../../colors/colors.dart';
import '../../../db/functions/adminfunction.dart';
import '../modification/container_decoration.dart';

class EditProfile extends StatefulWidget {
  final UserModel userdata;
  const EditProfile({Key? key, required this.userdata}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _adminNameController;
  late TextEditingController _ventureNameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _ventureNameController = TextEditingController(text: widget.userdata.name);
    _adminNameController =
        TextEditingController(text: widget.userdata.username);
    _phoneController = TextEditingController(text: widget.userdata.phone);
    _bioController = TextEditingController(text: widget.userdata.bio);
    _ageController = TextEditingController(text: widget.userdata.age);
    _selectedImagePath = widget.userdata.imagePath;
  }

  bool _validateInputs() {
    if (_adminNameController.text.isEmpty ||
        _ventureNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _ageController.text.isEmpty) {
      log("Please fill in all fields.");
      return false;
    }
    return true;
  }

  final ImagePicker _picker = ImagePicker();
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_validateInputs() || _formKey.currentState?.validate() != true) {
      log("Validation failed.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    bool updated = await updateUser(
      id: widget.userdata.id,
      username: _adminNameController.text,
      name: _ventureNameController.text,
      phone: _phoneController.text,
      bio: _bioController.text,
      age: _ageController.text,
      imagePath: _selectedImagePath ?? widget.userdata.imagePath,
    );

    if (updated) {
      log('Updated details');
      final updatedUser = UserModel(
        id: widget.userdata.id,
        email: widget.userdata.email,
        password: widget.userdata.password,
        username: _adminNameController.text,
        name: _ventureNameController.text,
        phone: _phoneController.text,
        bio: _bioController.text,
        age: _ageController.text,
        imagePath: _selectedImagePath ?? widget.userdata.imagePath,
      );
//      if (userBox != null) {
//   await userBox!.put(widget.userdata.id, currentUserNotifier.value);
// } else {
//   log("UserBox is not initialized.");
// }
      await userBox!.put(widget.userdata.id, updatedUser);

      currentUserNotifier.value = updatedUser;
      currentUserNotifier.notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully.')),
      );
      Navigator.pop(context);
    } else {
      log("Failed to update profile");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update failed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 29, 66, 77),
            expandedHeight: 250.0,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
                title: const Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lock_open, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16.0, top: 16.0),
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                        'assets/gif/welcome 2.json',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.4,
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: SizedBox(
                            width: screenWidth * 0.27,
                            height: screenWidth * 0.27,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: _selectedImagePath != null &&
                                        File(_selectedImagePath!).existsSync()
                                    ? ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.darken,
                                        ),
                                        child: Image.file(
                                          File(_selectedImagePath!),
                                          fit: BoxFit.cover,
                                          width: screenWidth * 0.27,
                                          height: screenWidth * 0.27,
                                        ),
                                      )
                                    : ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.darken,
                                        ),
                                        child: Image.asset(
                                          'assets/liquid/Timeline-bro.png',
                                          fit: BoxFit.cover,
                                          width: screenWidth * 0.27,
                                          height: screenWidth * 0.27,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EditStyle(
                              icon: Icons.person,
                              label: 'Account name',
                              controller: _adminNameController,
                              validate: NameValidator.validate,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.business_outlined,
                              controller: _ventureNameController,
                              label: 'Venture Name',
                              validate: VentureValidator.validate,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.phone,
                              controller: _phoneController,
                              label: 'Phone Number',
                              validate: PhoneNumberValidator.validate,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.cake,
                              controller: _ageController,
                              label: 'Age',
                              validate: AgeValidatorField.validate,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.notes,
                              controller: _bioController,
                              label: 'Bio',
                              validate: BioValidatorField.validate,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            InkWellButton(
                              buttomColor:
                                  const Color.fromARGB(255, 29, 66, 77),
                              onPressed: _saveProfile,
                              text: 'Save Changes',
                              textColor:
                                  const Color.fromARGB(255, 236, 236, 236),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
