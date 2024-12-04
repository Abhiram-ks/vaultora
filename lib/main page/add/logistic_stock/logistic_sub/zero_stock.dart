
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ZeroStock extends StatefulWidget {
  final String title;
  final List<Color> gradientColors1;
  final List<Color> gradientColors2;
  final double right;
  final double bottom;
  final VoidCallback onTap;
  final String description;
  final int itemCount;

  const ZeroStock({
    super.key,
    required this.title,
    required this.gradientColors1,
    required this.gradientColors2,
    required this.right,
    required this.bottom,
    required this.onTap,
    required this.description,
    required this.itemCount,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ZeroStockState createState() => _ZeroStockState();
}

class _ZeroStockState extends State<ZeroStock> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onTap,
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
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Product : ${widget.itemCount}',
                          style: GoogleFonts.kodchasan( 
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ReadMoreText(
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
                            ],
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