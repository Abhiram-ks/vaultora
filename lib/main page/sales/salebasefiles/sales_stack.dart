import 'package:flutter/material.dart';

class SalesStack extends StatelessWidget {
  final Widget ther;

  const SalesStack({super.key, required this.ther});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        SizedBox(
          height: screenHeight * 0.2,
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 29, 66, 77),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Add Sale Products',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0.1,
          ),
        ),
        ther,
      ],
    );
  }
}


