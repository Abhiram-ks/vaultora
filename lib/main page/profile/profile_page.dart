import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/profile/container_decoration.dart';
import 'package:vaultora_inventory_app/main%20page/stackBackgroud/background_stack.dart';

import '../../colors/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 66, 77),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Icon(Icons.lock_person, color: textColor2),
              const SizedBox(width: 8),
              Text(
                'Full Name',
                style: TextStyle(color: textColor2),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundStack(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.28),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.08),
                              const BlurredContainer(
                                text: 'user name',
                                height: 55,
                              ),
                              const SizedBox(height: 16),
                              const BlurredContainer(
                                text: 'Phone number',
                                height: 55,
                              ),
                              const SizedBox(height: 16),
                              const BlurredContainer(
                                text: 'Add Bio',
                                height: 100,
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWellButton(
                                  onPressed: () {
                                  },
                                  text: 'Edit Profile',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundImage:
                              AssetImage('assets/profile_image.png'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Settings and Logout Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading:
                              Icon(Icons.document_scanner, color: Colors.black),
                          title: Text('Terms & Conditions'),
                        ),
                        ListTile(
                          leading: Icon(Icons.privacy_tip, color: Colors.black),
                          title: Text('Privacy Policy'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.info_outline, color: Colors.black),
                          title: Text('Overview'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.help_outline, color: Colors.black),
                          title: Text('About'),
                        ),
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.red),
                          title: Text('Logout',
                              style: TextStyle(color: Colors.red)),
                          onTap: () {
                            // Add logout functionality
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'v1.0.0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
