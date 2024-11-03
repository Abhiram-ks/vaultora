import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../../../colors/colors.dart';
import '../../../login/loginSignin/welcome_screen.dart';

class DialogBox {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: Lottie.asset(
                    'assets/gif/logout white.json',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No', style: TextStyle(color: textColor2)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: textColor1,
                          ),
                          onPressed: () async {
                            await logout(context);
                          },
                          child:
                              Text('Yes', style: TextStyle(color: textColor2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  static Future<void> logout(BuildContext context) async {
    var sessionBox = await Hive.openBox('sessionBox');
    await sessionBox.delete('lastLoggedUser');
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const CheckScreen(),
      ),
      (route) => false,
    );
  }
}

class CatageryBox {
  static void showLogoutDialog(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Catagery',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.camera_alt_rounded),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Add image',
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 66, 77),
                        ),
                      ),
                    ],
                  ),
                  ClipRect(
                    
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'assets/images/logout_icon.png',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.category_sharp,
                          size: 28,
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Flexible(
                          child: TextFormField(
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: const Color.fromARGB(221, 105, 105, 105),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Catagery Name',
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 29, 66, 77),
                              ),
                              border: InputBorder.none,
                            ),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
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
                        backgroundColor: textColor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
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
        );
      },
    );
  }
}
