import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class checkScreen extends StatefulWidget {
  const checkScreen({super.key});

  @override
  State<checkScreen> createState() => _checkScreenState();
}

class _checkScreenState extends State<checkScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // return Scaffold(
    //   body: Center(
    //     // child: Text('data'),
    //     child:
    // ),
    // );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome/main image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                ),
                height: screenHeight * 0.3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      child: Lottie.asset(
                        'assets/gif/welcome_vaultora.json',
                        fit: BoxFit.contain,
                        height: screenHeight * 0.6,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.2,
              ),
              Text(
                'Vaultora',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'An admin inventory app streamlines\n'
                'stock management, orders, and alerts\n'
                'for efficient operations.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: ElevatedButton(
                        onPressed: () {},
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3451FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                        child: Text('Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: screenHeight*0.02),
               Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal:  screenWidth * 0.1)),
                  Text('Already have an account?',
                  style: TextStyle(color: Colors.white),),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Text(
                      '\tLogin',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 102, 255)
                      ),
                    ),
                  )
                ],
               ),
               SizedBox(height: screenHeight*0.11,)
            ],
          ))
        ],
      ),
    );
  }
}
