import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/Category_add/category_add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/settings/blur_settings_container.dart';
import 'package:vaultora_inventory_app/screen_dashboard/settings/caleder_marker.dart';
import 'package:vaultora_inventory_app/screen_dashboard/settings/privacy.dart';
import 'package:vaultora_inventory_app/screen_dashboard/settings/terms_condition.dart';

import '../../Color/colors.dart';

import '../common/dialog_box.dart';
import '../logistic/logistic.dart';
import '../revenue/revanue.dart';

// ignore: must_be_immutable
class ListSettingsContier extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  String username;

  ListSettingsContier(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.username});
    
    Future<void> sendFeedback() async{
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'abhiramks0001@gmail.com',
        query: 'subject=Feedback for Inventory App&body=Hi Team,%0A%0AI would like to share the following feedback:%0A%0A',
      );
      try {
        await launchUrl(emailLaunchUri);
      } catch (e) {
          debugPrint("Error sending feedback: $e");
      }
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 111, 111, 111).withOpacity(0.66),
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
                      builder: (context) => const TermsCondition()),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            ClickableRowItem(
              icon: Icons.security_rounded,
              text: 'Privacy Policy',
              bgcolor: black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Privacy()),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            ClickableRowItem(
              icon: Icons.bar_chart_rounded,
              text: 'Overview',
              bgcolor: black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RevanuePage()),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            ClickableRowItem(
              icon: Icons.shopping_bag_outlined,
              text: 'Logistic',
              bgcolor: black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogisticPage()),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            ClickableRowItem(
              icon: Icons.category_sharp,
              text: 'Add Category',
              bgcolor: black,
              
              onTap: () {
                             showDialog(
                  context: context,
                  builder: (context) =>
                      AddCategoryDialog(userId: username),
                );
              }
              
            ),
            SizedBox(height: screenHeight * 0.02),
             ClickableRowItem(
              icon: Icons.feedback_outlined,
              text: 'Feedback',
              bgcolor: black,
              onTap:sendFeedback, 
            ),
            SizedBox(height: screenHeight * 0.02),
            ClickableRowItem(
  icon: Icons.calendar_month,
  text: 'Sales Calendar',
  bgcolor: black,
  onTap: () {
    showBottomSheet(
      context: context,
      backgroundColor: whiteColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      builder: (context) {
        return const CalederMarker();
      },
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7, 
      ),
      enableDrag: true,
      showDragHandle: true,
    );
  },
),

            SizedBox(height: screenHeight * 0.02),
            ClickableRowItem(
              icon: Icons.power_settings_new_sharp,
              text: 'Logout',
              bgcolor: redColor,
              onTap: () {
                DialogBox.showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
