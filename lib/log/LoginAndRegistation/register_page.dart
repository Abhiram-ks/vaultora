import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/db/helpers/adminfunction.dart';
import 'package:vaultora_inventory_app/screen_dashboard/common/snackbar.dart';
import 'package:vaultora_inventory_app/screen_dashboard/settings/terms_condition.dart';
import '../../Color/colors.dart';
import '../Autotication_singup/email.validate.dart';
import '../Autotication_singup/phone_validation.dart';
import '../Autotication_singup/validation.dart';
import '../Autotication_singup/vanture_validation.dart';
import 'login_page.dart';
import '../validation_login/bg_stack.dart';
import '../Autotication_singup/pass_validate.dart';
import '../validation_login/orline_dec.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ventureNameController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _agreeToTerms = ValueNotifier(false);
  String? _errorText;

  @override
  void dispose() {
    _ventureNameController.dispose();
    _adminNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _agreeToTerms.dispose();
    super.dispose();
  }

  bool _validateAndSubmit() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      if (!_agreeToTerms.value) {
        setState(() {
          _errorText = "You must agree to the terms";
        });return false;
      }_errorText = null;
      return true;
    } return false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).viewInsets.bottom > 0
        ? screenHeight * 0.09
        : screenHeight * 0.09;

    return Scaffold(
      backgroundColor: transParent,
      body: Stack(
        children: [
          const BgimageRegisterLogin(),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: topPadding),
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
                    ), SizedBox(height: screenHeight * 0.05),
                    Usenamefield(
                      controller: _adminNameController,
                      hintText: 'Enter Full Name',
                      labelText: 'Account Name',
                      validate: NameValidator.validate,
                    ),SizedBox(height: screenHeight * 0.03),
                    Usenamefield(
                      controller: _emailController,
                      labelText: 'Email Address',
                      hintText: 'Enter Email Address',
                      validate: EmailValidator.validate,
                    ),SizedBox(height: screenHeight * 0.03),
                    CustomPhonenumber(
                      controller: _phoneController,
                      hintText: '',
                      labelText: 'Phone Number',
                      validate: PhoneNumberValidator.validate,
                    ),SizedBox(height: screenHeight * 0.03),
                    Usenamefield(
                      controller: _ventureNameController,
                      hintText: 'Full name required',
                      labelText: 'Venture Name',
                      validate: VentureValidator.validate,
                    ),SizedBox(height: screenHeight * 0.03),
                    PasswordField(
                      controller: _passwordController,
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      validator: (value) {
                        return null;
                      },
                    ),SizedBox(height: screenHeight * 0.03),
                    PasswordField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      validator: (value) {
                        return ConfirmPasswordValidator.validate(
                          _passwordController.text,
                          value,
                        );
                      },
                    ),SizedBox(height: screenHeight * 0.01),
                    ValueListenableBuilder<bool>(
                      valueListenable: _agreeToTerms,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            Checkbox(
                              value: value,
                              onChanged: (newValue) {
                                _agreeToTerms.value = newValue!;
                                setState(() => _errorText = null);
                              },
                              activeColor: value ? Colors.blue : redColor,
                            ),const Text(
                              'I agree to the ',style: TextStyle(color: Colors.white54),
                            ),GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const TermsCondition(),));
                              },
                              child: const Text(
                                "terms & Conditions",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 6, 43, 255),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),if (_errorText != null) ...[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            _errorText!,
                            style: TextStyle(
                                color: redColor, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_validateAndSubmit()) {
                            CustomSnackBarCustomisation.show(
                              context: context, 
                              message:'Registering...',
                               messageColor: blue, 
                               icon: Icons.satellite_alt_rounded, 
                               iconColor: blue);
                            bool isSuccess = await addUser(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              name: _ventureNameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              username: _adminNameController.text,
                              pass: _passwordController.text,
                            );
                            if (isSuccess) {
                              developer.log("User added");
                              CustomSnackBarCustomisation.show(
                                context: context,
                                 message: 'Successfully registered!',
                                  messageColor: green, 
                                  icon: Icons.cloud_done_outlined,
                                   iconColor: green);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            } else {
                              developer.log("Failed to add user");
                              CustomSnackBarCustomisation.show(
                                context: context,
                                icon: Icons.wifi_tethering_error,
                                iconColor: redColor,
                                message:  'Failed to register. Please try again.',
                                messageColor: redColor
                              );
                            }
                          }
                        }, style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3451FF),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),child: Text(
                          'Register',
                          style: TextStyle(
                            color: textColor2,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ), SizedBox(height: screenHeight * 0.02),
                    const OrCall( text: 'or',
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white54),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                          },
                          child: const Text(
                            " Login",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
