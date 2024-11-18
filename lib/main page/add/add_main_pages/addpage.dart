import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_main_pages/add_products.dart';
import '../../../db/models/user/user.dart';
import '../add_product/appbar.dart';


class Addpage extends StatefulWidget {
  final UserModel userDetails;
  const Addpage({super.key, required this.userDetails});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBar(
          titleText: 'Add to catalog',
          animationPath: 'assets/category/animation(6).json'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.024),
              CustomContainer(
                lottieFile: 'assets/category/add_purchases.json',
                title: 'Add Product',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1: const [
                   Color.fromARGB(255, 0, 30, 54),
                   Color.fromARGB(255, 88, 180, 255),
                ],
                gradientColors2: const [
                   Color.fromARGB(255, 0, 133, 243),
                    Color.fromARGB(255, 215, 237, 255),
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
                screen: AddProducts(userDetails: widget.userDetails),
              ),
              SizedBox(height: screenHeight * 0.024),
              CustomContainer(
                lottieFile: 'assets/gif/twoanimation.json',
                title: 'Add Sales',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1: const[
                  
                  Color.fromARGB(255, 80, 64, 0),
                  Color.fromARGB(255, 255, 153, 0),
                ],
                gradientColors2: const[
                  Color.fromARGB(255, 255, 227, 184),
                  Color.fromARGB(255, 235, 151, 61),
                
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
                screen: AddProducts(userDetails: widget.userDetails),
              ),
              SizedBox(height: screenHeight * 0.024),
              CustomContainer(
                lottieFile: 'assets/category/add_sales.json',
                title: 'Revanue',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1:const [
                   Color.fromARGB(255, 15, 53, 0),
                   Color.fromARGB(255, 193, 255, 195)
                ],
                gradientColors2: const[
                   Color.fromARGB(255, 168, 250, 170),
                   Color.fromARGB(255, 0, 71, 2)
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
                screen: AddProducts(userDetails: widget.userDetails),
              ),
              SizedBox(height: screenHeight * 0.024),
               CustomContainer(
                lottieFile: 'assets/category/truck.json',
                title: 'Stock Level',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1:const [
                  
                   Color.fromARGB(255, 246, 0, 180),
                    Color.fromARGB(255, 53, 0, 39),
                ],
                gradientColors2: const[
                   Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 255, 163, 231),
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
                screen: AddProducts(userDetails: widget.userDetails),
              ),SizedBox(height: screenHeight*0.12,)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  final String title;
  final List<Color> gradientColors1;
  final List<Color> gradientColors2;
  final String lottieFile;
  final double right;
  final double bottom;
  final double lottieSize;
  final Widget screen;
  final String description; 

  const CustomContainer({
    super.key,
    required this.title,
    required this.gradientColors1,
    required this.gradientColors2,
    required this.lottieFile,
    required this.right,
    required this.bottom,
    required this.lottieSize,
    required this.screen,
    required this.description,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _isFirstGradient = true;

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        _isFirstGradient = !_isFirstGradient;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => widget.screen));
      },
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: ColorTween(
          begin: _isFirstGradient
              ? widget.gradientColors1[0]
              : widget.gradientColors2[0],
          end: _isFirstGradient
              ? widget.gradientColors2[0]
              : widget.gradientColors1[0],
        ),
        builder: (context, Color? color1, child) {
          return TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            tween: ColorTween(
              begin: _isFirstGradient
                  ? widget.gradientColors1[1]
                  : widget.gradientColors2[1],
              end: _isFirstGradient
                  ? widget.gradientColors2[1]
                  : widget.gradientColors1[1],
            ),
            builder: (context, Color? color2, child) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color1!, color2!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Positioned(
                      right: widget.right,
                      bottom: widget.bottom,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Lottie.asset(
                          widget.lottieFile,
                          fit: BoxFit.cover,
                          width: widget.lottieSize,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.only(left: 25, top: 25),
                        child: Text(
                          widget.title,
                          style: GoogleFonts.kodchasan(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.3, 
                          child: ReadMoreText(
                            widget.description,
                            trimLines: 2,
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Show less',
                            style: GoogleFonts.kodchasan(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            lessStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            moreStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
