import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/screen_dashboard/common/appbar.dart';


class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
       double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar:const MyAppBarlast(titleText: 'Terms & Conditons'),
      body: Padding(
       padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.02,vertical: screenHeight*0.02),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150)).then(
                (value) {
                  return rootBundle
                      .loadString('assets/privacy/terms_conditon.md');
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data!,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(color: black),
                      h1: TextStyle(color:black),
                      h2: TextStyle(color:black),
                      h3: TextStyle(color: black),
                      h4: TextStyle(color:black),
                      h5: TextStyle(color:black),
                      h6: TextStyle(color:black),
                      listBullet: TextStyle(color:black),
                    ),
                  );
                }
                return  Center(
                  child: CircularProgressIndicator(
                    color: inside,
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}