import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/login/decorationLand/bg_image.dart';
import '../../db/models/user.dart';
import '../../main page/main_page.dart';
import '../decorationLand/decoration2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _vaultoraSlideAnimation;
  late Animation<Offset> _welcomeSlideAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _emailError = '';
  String _passwordError = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _vaultoraSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _welcomeSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  void _validateAndLogin() {
    setState(() {
      _emailError = '';
      _passwordError = '';
    });

    bool isValid = true;

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Please enter your emailId';
      });
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password';
      });
      isValid = false;
    }

    if (isValid) {
      _login();
    }
  }

  Future<void> _login() async {
    var userDB = await Hive.openBox<UserModel>('user_db');
    var sessionBox = await Hive.openBox('sessionBox');
    String emailId = _emailController.text.trim();
    String password = _passwordController.text.trim();

    bool userFound = false;
    for (var element in userDB.values) {
      if (element.email == emailId && element.password == password) {
        await sessionBox.put('lastLoggedUser', element);
        userFound = true;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Homepage(userdetails: element),
          ),
        );
        break;
      }
      //      if (element is UserModel) {
      //   if (element.email == emailId && element.password == password) {
      //     await sessionBox.put('lastLoggedUser', element);
      //     userFound = true;

      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => Homepage(userdetails: element),
      //       ),
      //     );
      //     break;
      //   }
      // }
    }

    if (!userFound) {
      setState(() {
        _emailError = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double titleFontSize = screenWidth * 0.07;
    double subtitleFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BgimageRegisterLogin(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.07),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/welcome/Screenshot_2024-10-22_112608-transformed.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SlideTransition(
                      position: _vaultoraSlideAnimation,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Vaultora',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tech You Can Trust, Prices You\'ll Love!',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.14),
                    SlideTransition(
                      position: _welcomeSlideAnimation,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome back!',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    EmailField(
                      labelText: 'Email Id',
                      hintText: 'Enter your Email Id',
                      controller: _emailController,
                    ),
                    if (_emailError.isNotEmpty)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _emailError,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.03),
                    PasswordField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      validator: PasswordValidatorTwo.validate,
                    ),
                    if (_passwordError.isNotEmpty)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _passwordError,
                          style:const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.07),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validateAndLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3451FF),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child:const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
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


class EmailTwoValidator {
  static String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email) ? null : 'Please enter a valid email address';
  }
}

class PasswordValidatorTwo {
  static String? validate(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 4 || password.length > 8) {
      return 'Password must be between 4 and 8 characters';
    }
    return null;
  }
}