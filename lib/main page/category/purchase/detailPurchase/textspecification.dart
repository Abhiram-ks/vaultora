import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';


class TextFormSpecification extends StatelessWidget {
  final String text;

  const TextFormSpecification({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.kodchasan(
        fontSize: 20,
         color:const Color.fromARGB(255, 121, 121, 121),
        fontWeight: FontWeight.w500,
      ),
      overflow: TextOverflow.ellipsis, 
      maxLines: 1,                    
    );
  }
}

class TextFormSpecificationtwo extends StatelessWidget {
  final String text;

  const TextFormSpecificationtwo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.kodchasan(
        fontSize: 20,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w500,
      ),
      overflow: TextOverflow.ellipsis, 
      maxLines: 3,                    
    );
  }
}
class CustomReadMoreText extends StatelessWidget {
  final String text;

  const CustomReadMoreText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 2,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Read more',
      trimExpandedText: 'Show less',
      style: GoogleFonts.kodchasan(
        fontSize: 16,
        color: Colors.black,
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
    );
  }
}

