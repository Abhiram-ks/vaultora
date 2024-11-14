import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Searchbarmain extends StatefulWidget {
  final String hintText;
  final VoidCallback onSearchPressed;
  final VoidCallback onClearPressed;

  const Searchbarmain({
    Key? key,
    required this.hintText,
    required this.onSearchPressed,
    required this.onClearPressed,
  }) : super(key: key);

  @override
  State<Searchbarmain> createState() => _SearchbarmainState();
}

class _SearchbarmainState extends State<Searchbarmain> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
     double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height:screenHeight *0.07,
      padding:const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset:const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
         const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey, 
                  fontSize: screenWidth * 0.04, 
                ),
                border: InputBorder.none,
              ),
            ),
          ),
              GestureDetector(
            onTap: () {
              _controller.clear();
              widget.onClearPressed();
            },
            child: SizedBox(
              width: screenWidth * 0.08, 
              height: screenWidth * 0.08, 
              child: Lottie.asset(
                'assets/category/wrong.json', 
                fit: BoxFit.cover, 
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding:const  EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
         color:const Color(0xFF68C5CC),
                borderRadius: BorderRadius.circular(10), 
              ),
              child: ElevatedButton(
                onPressed: widget.onSearchPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 10),  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), 
                  ),
                ),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04, 
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
