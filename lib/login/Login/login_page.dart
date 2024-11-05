import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:vaultora_inventory_app/login/decorationLand/bg_image.dart';
import 'package:vaultora_inventory_app/login/decorationLand/flash_message.dart';
import '../../db/models/user/user.dart';
import '../../main page/main_page.dart';
import '../decorationLand/decoration2.dart';
import '../validation/validation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
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
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndLogin() {
    setState(() {
      _emailError = '';
      _passwordError = '';
    });

    bool isValid = true;

    final emailError = EmailTwoValidator.validate(_emailController.text);
    final passwordError =
        PasswordValidatorTwo.validate(_passwordController.text);

    if (emailError != null) {
      setState(() {
        _emailError = emailError;
      });
      isValid = false;
    }
    if (passwordError != null) {
      setState(() {
        _passwordError = passwordError;
      });
      isValid = false;
    }

    if (isValid) {
      _login();
    } else {
      CustomDialog(context: context).show();
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
        
        await userDB.put(element.id, element);
        await sessionBox.put('lastLoggedUser', element);
        userFound = true;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Homepage(userDetails: element),
          ),
        );

        break;
      }
    }

    if (!userFound) {
      setState(() {
        CustomError(context: context).show();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double titleFontSize = screenWidth * 0.1;
    double subtitleFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
       const BgimageRegisterLogin(),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: const [
                                  Color.fromARGB(255, 58, 58, 58),
                                  Colors.white,
                                  Color.fromARGB(255, 100, 100, 100)
                                ],
                                stops: [
                                  _animation.value - 0.2,
                                  _animation.value,
                                  _animation.value + 0.2
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            child: child,
                          );
                        },
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: const [
                                  Color.fromARGB(255, 58, 58, 58),
                                  Colors.white,
                                  Color.fromARGB(255, 100, 100, 100)
                                ],
                                stops: [
                                  _animation.value - 0.2,
                                  _animation.value,
                                  _animation.value + 0.1
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            child: child,
                          );
                        },
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
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
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
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
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
                        child: const Text(
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
