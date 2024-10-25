import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';
import 'package:vaultora_inventory_app/login/decorationLand/decoration_landing.dart';
import 'package:vaultora_inventory_app/login/loginSignin/login_screen.dart';
import 'package:vaultora_inventory_app/login/decorationLand/decoration.dart';
import 'package:vaultora_inventory_app/login/decorationLand/decoration2.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _adminnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _agreeToTerms = ValueNotifier(false);
  String? _errorText;

  @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    final keyboardVisible = mediaQuery.viewInsets.bottom > 0;
    final topPadding = keyboardVisible ? screenHeight * 0.1 : screenHeight*0.16;
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome/main image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.83),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox( height: topPadding ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        'Start with your free account today.',
                        style: GoogleFonts.poppins(
                          color: textColor2,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    const CustomTextField(
                      labelText: 'Account Name',
                      hintText: 'Enter your full name',
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const CustomTextFieldtwo(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const CustomPhonenumber(
                      labelText: 'Phone Number',
                      hintText: '',
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const PasswordField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ValueListenableBuilder<bool>(
                      valueListenable: _agreeToTerms,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            Checkbox(
                              value: value,
                              onChanged: (newValue) {
                                _agreeToTerms.value = newValue!;
                                _errorText = null;
                              },
                              activeColor: Colors.blue,
                            ),
                           const Text(
                              'I agree to the ',
                              style: TextStyle(color: Colors.white54),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle terms & policy tap here
                              },
                              child: const Text(
                                "terms & policy",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 6, 43, 255),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color.fromARGB(255, 6, 43, 255),
                                  decorationThickness: 1.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          _errorText!,
                          style: TextStyle(color: redColor, fontSize: 9),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.015),
                   SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_agreeToTerms.value) {
                            // Add registration functionality here
                          } else {
                            setState(() {
                              _errorText = 'Please agree to the terms & policy';
                            });
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>const LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3451FF),
                          padding:const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: textColor2,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: screenHeight*0.02),
                    const OrCall(),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white54),
                        ),
                        GestureDetector(
                          onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const LoginScreen(),));
                          },
                          child: const Text(" Login",
                          style: TextStyle(
                            color:  Color.fromARGB(255, 6, 43, 255),
                          ),
                          ),
                        )
                      ],
                     )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
