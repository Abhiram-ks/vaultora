import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/main%20page/profile/modification/container_decoration.dart';
import 'package:vaultora_inventory_app/main%20page/profile/modification/settings.dart';
import '../../../colors/colors.dart';
import '../../../db/functions/adminfunction.dart';
import '../../category/category_page.dart';
import '../DialogBox/dialog_box.dart';
import '../edit_profile.dart/edit_profille.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userDetails});
  final UserModel userDetails;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    await initUserDB();
    final user = userBox!.get(widget.userDetails.id);
    if (user != null) {
      currentUserNotifier.value = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ValueListenableBuilder<UserModel?>(
      valueListenable: currentUserNotifier,
      builder: (context, value, _) {
        if (value == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
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
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lock_person, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            value.username,
                            style: const TextStyle(color: Colors.white),
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
                            child: SizedBox(
                              width: screenWidth *
                                  0.27,
                              height:
                                  screenWidth * 0.27, 
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: value.imagePath != null &&
                                          value.imagePath!.isNotEmpty
                                      ? ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken,
                                          ),
                                          child: Image.file(
                                            File(value.imagePath!),
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
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 82, 82, 82)
                                .withOpacity(0.66),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.05,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.cake,
                                        color: textColor2,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        value.age.toString(),
                                        style: TextStyle(color: textColor2),
                                      ),
                                    ],
                                  ),
                                ),
                                BlurredContainer(
                                  icon: Icons.person_2,
                                  maintext: 'Account Name',
                                  text: value.username,
                                  height: screenHeight * 0.068,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                BlurredContainer(
                                  icon: Icons.business_outlined,
                                  maintext: 'Venture Name',
                                  text: value.name,
                                  height: screenHeight * 0.068,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                BlurredContainer(
                                  icon: Icons.phone,
                                  maintext: 'Phone Number',
                                  text: value.phone,
                                  height: screenHeight * 0.068,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                BlurredContainer(
                                  icon: Icons.notes_sharp,
                                  maintext: 'Bio',
                                  text: value.bio,
                                  height: 100,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                InkWellButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                        // userdata: widget.userDetails,
                                        userdata: value,
                                      ),
                                    ));
                                  },
                                  buttomColor:
                                      const Color.fromARGB(255, 228, 228, 228),
                                  text: 'Edit Profile',
                                  textColor:
                                      const Color.fromARGB(255, 47, 47, 47),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 111, 111, 111)
                              .withOpacity(0.66),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ClickableRowItem(
                                icon: Icons.file_open,
                                text: 'Terms & Conditions',
                                bgcolor: Colors.black,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CategoryPage()),
                                  );
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ClickableRowItem(
                                icon: Icons.security_rounded,
                                text: 'Privacy Policy',
                                bgcolor: Colors.black,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CategoryPage()),
                                  );
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ClickableRowItem(
                                icon: Icons.bar_chart_rounded,
                                text: 'Overview',
                                bgcolor: Colors.black,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CategoryPage()),
                                  );
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ClickableRowItem(
                                icon: Icons.category_sharp,
                                text: 'Add Category',
                                bgcolor: Colors.black,
                                onTap: () {
                                  CatageryBox.showLogoutDialog(context);
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ClickableRowItem(
                                icon: Icons.question_mark_sharp,
                                text: 'About',
                                bgcolor: Colors.black,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CategoryPage()),
                                  );
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ClickableRowItem(
                                icon: Icons.power_settings_new_sharp,
                                text: 'Logout',
                                bgcolor: Colors.red,
                                onTap: () {
                                  DialogBox.showLogoutDialog(context);
                                },
                              ),
                            ],
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
      },
    );
  }
}
