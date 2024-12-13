
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class HomeAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();


  @override
  Size get preferredSize =>
      const Size.fromHeight(80.0); 
}

class _HomeAppbarState extends State<HomeAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -0.2, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: screenHeight * 0.09,
      backgroundColor: whiteColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                
                animation: _animation,
                builder: (context, child) {
                  return ShaderMask(
                    
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        
                        colors:  [
                          const Color.fromARGB(255, 149, 149, 149),
                          whiteColor,
                          const Color.fromARGB(255, 124, 124, 124),
                        ],
                        stops: [
                          _animation.value - 0.2,
                          _animation.value,
                          _animation.value + 0.2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    
                    child: Text(
                      'Vaultora',
                      style: GoogleFonts.poppins(
                        color: whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors:  [
                          const Color.fromARGB(255, 149, 149, 149),
                          whiteColor,
                          const Color.fromARGB(255, 85, 85, 85),
                        ],
                        stops: [
                          _animation.value - 0.2,
                          _animation.value,
                          _animation.value + 0.2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      'Tech You Can Trust, Prices You’ll Love!',
                      style: GoogleFonts.poppins(
                        color:whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1, 
                      overflow: TextOverflow
                          .ellipsis,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

